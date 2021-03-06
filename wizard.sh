#!/bin/bash

####################################################################################################
#
# Example:
#    Deploy and run wizard against master
#         ./wizard.sh 
#    Deploy and test wizard against master. Wizard will execute and then exit before the menu.
#         ./wizard.sh 
#    Use the current branch for the build and enable debugging
#         ./wizard.sh -d -b=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
#    Local deployment using the current branch debugging enabled (DEVELOPMENT ONLY!)
#         ./wizard.sh -l -d -b=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
#
####################################################################################################

start_time=$(date +"%s.%N")

assert() {
    if [ $# -gt 0 ]; then echo "ASSERT: $(basename $0) : ${1}"; fi
    exit 1
}

debugging() {
    if [[ ${debug_flag} ]]; then
	echo "DEBUGGING: $(date +"%T") : $(bc <<<$(date +"%s.%N")-${start_time}) :$(basename $0) : ${1}"
    fi
}

# parse commandline
for i in "$@"; do
  case $i in
    -h|--help)
	echo "Usage: $(basename $0)"
	echo "	  [-i|--init]"
	echo "	  [-t|--test]"
	echo "	  [-l|--local]"
	echo "	  [-d|--debug=]"
	echo "	  [-c|--config=]"
	echo "	  [-b|--branch=]"
	echo ""
	exit 0
        shift
        ;;
    -b=*|--branch=*)
	if [ -n ${i#*=} ]; then
	    wizard_branch="${i#*=}"
	else
	    assert "Branch name must be provided";
	fi
	shift
	;;
    -c=*|--config=*)
	config_file="${i#*=}"
	if [ -z ${config_file} ];
	    then assert "config file not provided: ${config_file}" 
	elif [[ ! -r ${config_file} ]];
	    then assert "failed to access config file: ${config_file}";
	fi
	shift
	;;
    -d|--debug)
	debug_flag="${i#*=}"
	shift
        ;;
    -d=*|--debug=*)
	debug_flag="${i#*=}"
	shift
        ;;
    -l|--local)
        run_local="--local"
	shift
        ;;
    -t|--test)
        test_wizard="--test"
	shift
        ;;
    -i|--init)
        init_flag="--init"
        shift
        ;;
    *)
    echo "$i is not a valid command line option."
    echo ""
    echo "For help, please use $0 -h"
    echo ""
    exit 1
    ;;
    esac
    shift
done

init_venv_python() {
    if [[ ${python_version} == 2 ]]; then
        pyver="";
    else 
        pyver="3";
    fi
    echo "Initializing Virtual Environment using Python ${python_version}"
    #Validate and initialize virtualenv
    if [ "$(virtualenv --version -p python${pyver} > /dev/null 2>&1; echo $?)" -ne 0 ]; then
        #Validating pip
	which pip > /dev/null 2>&1
	if [ $? -ne 0 ]; then
            echo "ERROR: missing package: pip (attempting to install using get-pip.py)"
            curl -s -o ${pip_path} ${pip_url}
            if [ ! -r ${pip_path} ]; then assert "failed to download get-pip.py (from ${pip_url})"; fi
            python${pyver} ${pip_path}
            if [ $? -ne 0 ]; then
                echo "ERROR: failed to install package: pip (attempting to install via 'sudo get-pip.py')"
                sudo python${pyver} ${pip_path} > /dev/null 2>&1
                if [ $? -ne 0 ]; then
                    assert "Please install package: pip"
                fi
            fi
        fi
	echo "ERROR: missing python package: virtualenv (attempting to install via 'pip install virtualenv')"
        # Attemping to Install virtualenv
	pip${pyver} install virtualenv > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "ERROR: failed to install python package (attempting to install via 'sudo pip install virtualenv')"
            sudo pip${pyver} install virtualenv > /dev/null 2>&1
            if [ $? -ne 0 ]; then
                assert "Please install the 'virtualenv' module using 'pip install virtualenv'"
            fi
        fi
    fi
    cd ${wizard_basedir}
    virtualenv -p python${pyver} ${wizard_venv} > /dev/null 2>&1
    if [ ! -r ${venv_python} ]; then assert "failed to initialize virtual environment"; fi

    debugging "Upgrade pip"
    # upgrade pip
    (. ${venv_activate} && pip install pip --upgrade > /dev/null 2>&1)
}

## main

if [ -z ${wizard_branch} ]; then wizard_branch=master; fi
wizard_basedir=~/.pf9-wizard
venv_python=${wizard_venv}/bin/python
venv_activate=${wizard_venv}/bin/activate
wizard_url=https://raw.githubusercontent.com/platform9/express-wizard/${wizard_branch}/wizard.py
pip_url=https://bootstrap.pypa.io/get-pip.py
pip_path=/tmp/get_pip.py


# initialize installation directory

if [ -n ${run_local} ];then
    wizard_basedir=$(pwd)

else
    if [[ -n ${init_flag} ]]; then
	debugging "DELETEING wizard_basedir: ${wizard_basedir}"
	if [ -d ${wizard_basedir} ]; then
	    rm -rf ${wizard_basedir}
	    if [ -d ${wizard_basedir} ]; then assert "failed to remove ${wizard_basedir}"; fi
	fi
    fi
    if [ ! -d ${wizard_basedir} ]; then
	mkdir -p ${wizard_basedir}
	if [ ! -d ${wizard_basedir} ]; then assert "failed to create directory: ${wizard_basedir}"; fi
    fi
fi

# validate python stack
which python > /dev/null 2>&1
if [ $? -ne 0 ]; then assert "Python stack missing"; fi

# Merge runtime arguments
if [[ -n ${wizard_branch} ]]; then args+=" --branch ${wizard_branch}";fi
if [[ -n ${test_wizard} ]]; then args+=" ${test_wizard}";fi
if [[ -n ${run_local} ]]; then args+=" ${run_local}";fi
if [[ -n ${config_file} ]]; then args+=" --config ${config_file}";fi
if [[ -n ${debug_flag} ]]; then 
    if [[ ${debug_flag} == "-d" || ${debug_flag} == "--debug"  ]]; then
	args+=" --debug 1"
    else
	args+=" --debug ${debug_flag}"
    fi
fi

# NEED TO SET THIS ENV VARIABLE SO IT WILL CREATE THE venv in the project
#                 PIPENV_VENV_IN_PROJECT
pip install --user pipenv
mkdir -p ${wizard_basedir} 
cd ${wizard_basedir}
#pipenv install -e git+git://github.com/platform9/express-wizard.git@tomchris/setuptools#egg=express-wizard
pipenv install -e git+git://github.com/platform9/express-wizard.git@${wizard_branch}
# Enter a subshell in the virtualenv
pipenv run wizard
exit(0)
eval pipenv shell
wizard_venv=$(eval "pipenv --venv")
debugging(${wizard_venv})
launch_wizard="(. ${venv_activate} && ${venv_python} ${wizard_script}${args})"

#pipenv run  # Run a command in the virtualenv


########################################
# REQUIRED PIP INSTALLS BEFORE INSTALLING WIZARD
#
#    python -m pip install --upgrade pip wheel setuptool
#   
#    setuptools-45.1.0
#    





exit(0)
# configure python virtual environment
debugging "Configuring virtualenv"
if [ "$(ls -A ${wizard_venv} > /dev/null 2>&1; echo $?)" -ne 0 ]; then
    for ver in {3,2}; do #ensure python3 is first
	debugging "Checking Python${ver}: $(which python${ver})"
        if [ "$(which python${ver} > /dev/null 2>&1)" ]; then
	    python_version="$(python${ver} <<< 'import sys; print(sys.version_info[0])')"
	    debugging "Python Version Selected: ${python_version}"
	    break
        #else
	python_version=$(python -V) #Grep or split version from here and validate it is [2,3]
        fi
    done
    init_venv_python
else
    echo "INFO: using exising virtual environment"
fi

launch_wizard="(. ${venv_activate} && ${venv_python} ${wizard_script}${args})"
debugging "Wizard launch command: ${launch_wizard}"

# start pf9-wizard in virtual environment
flag_started=0
while [ ${flag_started} -eq 0 ]; do
    eval ${launch_wizard}
    if [ $? -eq 0 ]; then
        flag_started=1
    else
	stdout="$(eval ${launch_wizard} 2>&1 | grep 'Failed to import python module:')"
	module_regex=".*Failed to import python module.*"
	if [[ "${stdout}" =~ ${module_regex} ]]; then
	    module_name=$(echo "${stdout}" | cut -d : -f3 | awk -F ' ' '{print $1}' | sed -e "s/'//g")
	    echo "--> attempting to installing missing module: [${module_name}]"
	    eval "(. ${venv_activate}; pip install ${module_name} > /dev/null 2>&1)"
    	    if [ $? -ne 0 ]; then
		assert "failed to install missing module: ${module_name}"
	    fi
        else
	    assert "${stdout}"
        fi
    fi
done
