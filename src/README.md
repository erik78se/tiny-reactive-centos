# Overview

A reference charm for centos with reactice (python) code.

Uses layer basic.

# Deploy
This is known to be needed on a maas cloud.

## Configure your model

To deploy to a centos node, you need to prepare your model to make sure
python3 and yaml python libraries goes in with cloud-init. This is how:

Create a centos-model.yaml configuration file:

```yaml
cloudinit-userdata: |
  yum_repos:
    epel-release:
        baseurl: http://download.fedoraproject.org/pub/epel/7/$basearch
        enabled: true
        failovermethod: priority
        gpgcheck: true
        gpgkey: http://download.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
        name: Extra Packages for Enterprise Linux 7 - Release
  packages:
    - 'python3'
    - 'python36-PyYAML'
```
Create a new model
```juju add-model mycentosmodel```

Set the configuration on the model:

```juju model-config centos-model.yaml```

Deploy as normal in a cloud that has the centos6 or centos7 series:

```juju deploy build/builds/tiny-reactive-centos```




juju deploy cs:~erik-lonroth/tiny-reactive-centos

# Configuration

This charm has a single configuration option "foo".

# Contact Information
erik.lonroth@gmail.com
