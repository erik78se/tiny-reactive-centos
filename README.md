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

This completes the patching needed.

## Build

```make build```

The resulting charm ends up in: build/builds/tiny-reactive-centos 

## Deploy to MAAS
In a MAAS with a centos7 image

### Add new model, configure and deploy:
```sh
juju add-model my-maas-cloud my-centos-model
juju model-config  [maas-model-config-centos7.yaml](maas-things/maas-model-config-centos7.yaml)
juju deploy build/builds/tiny-reactive-centos
```

## Deploy to LXD
You lxd cloud needs to have a centos7 image with cloudinit. (Not covered here)

### Add new model, configure and deploy:
```
juju add-model my-lxd-cloud my-centos-model
juju model-config [lxd-centos-model-config.yaml](lxd-things/lxd-model-config-centos7-noproxy.yaml)
juju deploy build/builds/tiny-reactive-centos
```

## Alternatively, deply Erik Lonroth public version:

```juju deploy cs:~erik-lonroth/tiny-reactive-centos```

