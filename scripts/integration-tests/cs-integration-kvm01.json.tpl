{
  "actions": [
      {
          "operation": "discover-region",
          "region-name": "https://cs-integration.platform9.horse"
      },
      {
          "operation": "onboard-region",
          "region-name": "https://cs-integration.platform9.horse",
          "pmo-inventory": "all"
      },
      {
          "operation": "discover-region",
          "region-name": "https://cs-integration.platform9.horse"
      }
  ],
  "region": {
    "username": "soleng",
    "auth_type": "sshkey",
    "bond_ifname": "bond0",
    "bond_mode": "1",
    "du_type": "KVM",
    "auth_username": "centos",
    "tenant": "service",
    "dns_list": "",
    "password": "gAAAAABeQZmcLodSISuZWMCNjMJWOCTNiGZmTomWtWSx2TG7eFyd7qcVqdWt_ZQI3ozQiK-Eril2jj5_-cq6xeDRsyv9PHaoMQ==",
    "auth_password": "",
    "url": "https://cs-integration.platform9.horse",
    "region": "kvm01",
    "region_proxy": "",
    "git_branch": "master",
    "auth_ssh_key": "~/.ssh/id_rsa",
    "bond_mtu": "9000"
  },
  "hosts": [
    {
      "hostname": "kvm01",
      "du_url": "https://cs-integration.platform9.horse",
      "du_type": "kvm",
      "du_host_type": "kvm",
      "record_source": "User-Defined",
      "ip": "<ip-kvm01>",
      "fk_host_profile": "CentOS - Hypervisor",
      "pf9-kube": "n",
      "nova": "y",
      "glance": "y",
      "cinder": "n",
      "designate": "n"
    },
    {
      "hostname": "kvm02",
      "du_url": "https://cs-integration.platform9.horse",
      "du_type": "kvm",
      "du_host_type": "kvm",
      "record_source": "User-Defined",
      "ip": "<ip-kvm02>",
      "fk_host_profile": "CentOS - Hypervisor",
      "pf9-kube": "n",
      "nova": "y",
      "glance": "y",
      "cinder": "n",
      "designate": "n"
    },
    {
      "hostname": "kvm03",
      "du_url": "https://cs-integration.platform9.horse",
      "du_type": "kvm",
      "du_host_type": "kvm",
      "record_source": "User-Defined",
      "ip": "<ip-kvm03>",
      "fk_host_profile": "CentOS - Hypervisor",
      "pf9-kube": "n",
      "nova": "y",
      "glance": "n",
      "cinder": "n",
      "designate": "n"
    },
    {
      "hostname": "kvm04",
      "du_url": "https://cs-integration.platform9.horse",
      "du_type": "kvm",
      "du_host_type": "kvm",
      "record_source": "User-Defined",
      "ip": "<ip-kvm04>",
      "fk_host_profile": "CentOS - Hypervisor",
      "pf9-kube": "n",
      "nova": "y",
      "glance": "n",
      "cinder": "n",
      "designate": "n"
    }
  ],
  "host-profiles": [
    {
      "fk_role_profile": "Hypervisor with Glance",
      "host_profile_name": "CentOS - Hypervisor",
      "fk_bond_profile": "CentOS Bond Config 1 (ALB)",
      "fk_auth_profile": "CentOS SSH Access (Key-based)"
    },
    {
      "fk_role_profile": "Hypervisor with Glance",
      "host_profile_name": "CentOS - Hypervisor w/Glance",
      "fk_bond_profile": "CentOS Bond Config 2 (Round-Robin)",
      "fk_auth_profile": "CentOS SSH Access (Key-based)"
    },
    {
      "fk_role_profile": "Hypervisor with Cinder",
      "host_profile_name": "CentOS - Hypervisor w/Cinder",
      "fk_bond_profile": "CentOS Bond Config 2 (Round-Robin)",
      "fk_auth_profile": "CentOS SSH Access (Key-based)"
    },
    {
      "fk_role_profile": "Hypervisor with Designate",
      "host_profile_name": "CentOS - Hypervisor w/Designate",
      "fk_bond_profile": "CentOS Bond Config 2 (Round-Robin)",
      "fk_auth_profile": "CentOS SSH Access (Key-based)"
    },
    {
      "fk_role_profile": "Kubernetes Master",
      "host_profile_name": "Centos - Kubernetes Master",
      "fk_bond_profile": "CentOS Bond Config 1 (ALB)",
      "fk_auth_profile": "CentOS SSH Access (Key-based)"
    },
    {
      "fk_role_profile": "Kubernetes Worker",
      "host_profile_name": "Centos - Kubernetes Worker",
      "fk_bond_profile": "CentOS Bond Config 1 (ALB)",
      "fk_auth_profile": "CentOS SSH Access (Key-based)"
    },
    {
      "fk_role_profile": "Hypervisor with Glance",
      "host_profile_name": "Ubuntu - Hypervisor",
      "fk_bond_profile": "Ubuntu Bond Config 1 (ALB)",
      "fk_auth_profile": "Ubuntu SSH Access (Key-based)"
    },
    {
      "fk_role_profile": "Hypervisor with Glance",
      "host_profile_name": "Ubuntu - Hypervisor w/Glance",
      "fk_bond_profile": "Ubuntu Bond Config 2 (Round-Robin)",
      "fk_auth_profile": "Ubuntu SSH Access (Key-based)"
    },
    {
      "fk_role_profile": "Hypervisor with Designate",
      "host_profile_name": "Ubuntu - Hypervisor w/Designate",
      "fk_bond_profile": "Ubuntu Bond Config 2 (Round-Robin)",
      "fk_auth_profile": "Ubuntu SSH Access (Key-based)"
    },
    {
      "fk_role_profile": "Hypervisor with Cinder",
      "host_profile_name": "Ubuntu - Hypervisor w/Cinder",
      "fk_bond_profile": "Ubuntu Bond Config 2 (Round-Robin)",
      "fk_auth_profile": "Ubuntu SSH Access (Key-based)"
    },
    {
      "fk_role_profile": "Kubernetes Master",
      "host_profile_name": "Ubuntu - Kubernetes Master",
      "fk_bond_profile": "Ubuntu Bond Config 1 (ALB)",
      "fk_auth_profile": "Ubuntu SSH Access (Key-based)"
    },
    {
      "fk_role_profile": "Kubernetes Worker",
      "host_profile_name": "Ubuntu - Kubernetes Worker",
      "fk_bond_profile": "Ubuntu Bond Config 1 (ALB)",
      "fk_auth_profile": "Ubuntu SSH Access (Key-based)"
    }
  ],
  "bond-profiles": [
    {
      "bond_ifname": "bond0",
      "bond_name": "CentOS Bond Config 1 (ALB)",
      "bond_members": "ens160 ens192",
      "bond_mode": 6,
      "bond_mtu": "9000"
    },
    {
      "bond_ifname": "bond0",
      "bond_name": "CentOS Bond Config 2 (Round-Robin)",
      "bond_members": "ens160 ens192",
      "bond_mode": 0,
      "bond_mtu": "9000"
    },
    {
      "bond_ifname": "bond0",
      "bond_name": "Ubuntu Bond Config 1 (ALB)",
      "bond_members": "eth0 eth1",
      "bond_mode": 6,
      "bond_mtu": "9000"
    },
    {
      "bond_ifname": "bond0",
      "bond_name": "Ubuntu Bond Config 2 (Round-Robin)",
      "bond_members": "eth0 eth1",
      "bond_mode": 0,
      "bond_mtu": "9000"
    }
  ],
  "role-profiles": [
    {
      "pf9-kube": "",
      "nova": "y",
      "node_type": "",
      "role_name": "Hypervisor",
      "cinder": "n",
      "glance": "n",
      "designate": "n"
    },
    {
      "pf9-kube": "",
      "nova": "y",
      "node_type": "",
      "role_name": "Hypervisor with Glance",
      "cinder": "n",
      "glance": "y",
      "designate": "n"
    },
    {
      "pf9-kube": "",
      "nova": "y",
      "node_type": "",
      "role_name": "Hypervisor with Cinder",
      "cinder": "y",
      "glance": "n",
      "designate": "n"
    },
    {
      "pf9-kube": "",
      "nova": "y",
      "node_type": "",
      "role_name": "Hypervisor with Designate",
      "cinder": "n",
      "glance": "n",
      "designate": "y"
    },
    {
      "pf9-kube": "y",
      "nova": "",
      "node_type": "master",
      "role_name": "Kubernetes Master",
      "cinder": "",
      "glance": "",
      "designate": ""
    },
    {
      "pf9-kube": "y",
      "nova": "",
      "node_type": "worker",
      "role_name": "Kubernetes Worker",
      "cinder": "",
      "glance": "",
      "designate": ""
    }
  ],
  "auth-profiles": [
    {
      "auth_type": "sshkey",
      "auth_name": "CentOS SSH Access (Key-based)",
      "auth_password": "",
      "auth_username": "centos",
      "auth_ssh_key": "~/.ssh/id_rsa"
    },
    {
      "auth_type": "sshkey",
      "auth_name": "Ubuntu SSH Access (Key-based)",
      "auth_password": "",
      "auth_username": "ubuntu",
      "auth_ssh_key": "~/.ssh/id_rsa"
    }
  ]
}