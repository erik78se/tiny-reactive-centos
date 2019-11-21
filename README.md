# tiny-reactive-centos

A reference charm for centos

## Apply patches to layer-basic (2019-november)

This patch handles centos better. Its a PR waiting to get merged into the master.
https://github.com/juju-solutions/layer-basic/pull/148

```bash
mkdir layers
cd layers
git clone https://github.com/erik78se/layer-basic.git
git checkout centos_compatibility_fixes
cd ..
```

## Use hallbacks patch to charm-helpers
echo "-e git+https://github.com/hallback/charm-helpers@hallback/centosfixes#egg=charms.reactive" >> wheelhouse-overrides.txt

## Build
make build

## To deploy: configure your model

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
