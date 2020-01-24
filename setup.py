"""Install express-wizard"""

from setuptools import setup, find_packages
import sys
import os
from os import path
from io import open

here = path.abspath(path.dirname(__file__))

with open(path.join(here, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()

print("CLI_BRANCH: ", os.getenv('CLI_BRANCH'))

if os.getenv('CLI_BRANCH') and not None:
    cli_branch = os.getenv('CLI_BRANCH')
else:
    cli_branch="master"
    
if os.getenv('CLI_LOCAL_SRC'):
    express_cli_source = ('express-cli @ git+file://home/tomchris/Development/express-cli#egg=express-cli')
else:
    express_cli_source = ("express-cli @ git+git://github.com/platform9/express-cli.git@{}#egg=express-cli".format(cli_branch))


setup(
    name='express-wizard', 
    version='0.0.1', 
    description='Wizard for Platform9 express-cli and pf9-express', 
    long_description=long_description, 
    long_description_content_type='text/markdown',  
    url='https://github.com/Platform9/express-wizard',  
    author='Thomas Christopoulos',  
    author_email='tom.christopoulos@platform9.com',  
    classifiers=[
	'Development Status :: 3 - Alpha',
	'Intended Audience :: Developers',
	'Intended Audience :: Information Technology',
        'Topic :: Software Development :: Build Tools',
	'License :: OSI Approved :: Apache Software License',
	'Programming Language :: Python :: 2',
	'Programming Language :: Python :: 2.7',
	'Programming Language :: Python :: 3',
	'Programming Language :: Python :: 3.5',
	'Programming Language :: Python :: 3.6',
    ],
    packages=find_packages(exclude=['docs', 'tests*']),
    python_requires='>=2.7, !=3.0.*, !=3.1.*, !=3.2.*, !=3.3.*, !=3.4.*, <4',
    install_requires=[
        'requests',
        'urllib3',
        'prettytable',
        'argparse',
        'pprint',
        'openstacksdk==0.12.0',
        'cryptography',
        'pathlib',
        express_cli_source,
        ],
    entry_points = {
        'console_scripts': [
            'wizard=wizard:main',
            ],
    }, 
)