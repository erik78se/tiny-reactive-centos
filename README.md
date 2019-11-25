# tiny-reactive-centos

A reference charm for centos

## Apply patches to layer-basic (2019-november)
This is needed to get things working november 2019. Upstream patches submited.

### layer:basic patch
This patch handles centos better. Its a PR waiting to get merged into the master.
https://github.com/juju-solutions/layer-basic/pull/148

## Build
To build for Scania environment.

### Johan Hallbacks charm-helpers patch
```sh
echo "-e git+https://github.com/hallback/charm-helpers@hallback/centosfixes#egg=charms.reactive" >> wheelhouse-overrides.txt
```

```sh
mkdir layers
cd layers
git clone https://github.com/erik78se/layer-basic.git
git checkout centos_compatibility_fixes
cd ..
```

At this point we can build with our patches.

make build

## To deploy on MAAS: configure your model
This applies to MAAS + centos7 only.

Create a new model
```sh
juju add-model scania-maas-1 my-centos-model
```

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

Load the config into the model:
``'sh
juju model-config centos-model.yaml
```

Deploy your local build as normal in a cloud that has the centos6 or centos7 series:

```juju deploy build/builds/tiny-reactive-centos```

Alternatively, deply Erik Lonroth public version for reference.

```juju deploy cs:~erik-lonroth/tiny-reactive-centos```
