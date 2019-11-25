# tiny-reactive-centos

A reference charm for centos known to work on MAAS and LXD clouds.

## Apply patches to layer-basic (2019-november)
This is needed to get things working november 2019. Upstream patches submited.

This patch handles centos better. Its a PR waiting to get merged into the master.
  - https://github.com/juju-solutions/layer-basic/pull/148

Make charm build use a patched charm-helpers:
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

## Build
Once patched properly.

```make build```

The resulting charm ends up in: build/builds/tiny-reactive-centos 

## To deploy on MAAS: configure your model
This applies to MAAS + centos7 only.

Create a new model
```sh
juju add-model scania-maas-1 my-centos-model
```

Create a maas [maas-model-config-centos7.yaml](maas-things/maas-model-config-centos7.yaml) configuration file.

Load the config into the model:
``'sh
juju model-config maas-things/maas-model-config-centos7.yaml
```

Deploy your local build as normal in a cloud that has the centos6 or centos7 series:

```juju deploy build/builds/tiny-reactive-centos```

Alternatively, deply Erik Lonroth public version for reference.

```juju deploy cs:~erik-lonroth/tiny-reactive-centos```

## Deploy on lxd cloud
Load up a working model config as in [lxd-centos-model-config.yaml](lxd-things/lxd-model-config-centos7-noproxy.yaml)

```sh
juju model-config lxd-things/lxd-model-config-centos7-noproxy.yaml
juju deploy build/builds/tiny-reactive-centos

```
