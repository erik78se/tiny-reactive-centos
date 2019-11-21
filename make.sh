# layer basic lives here
echo "Dont forget to prepare the model with some metadata:"
echo "erik@bionic-dev-1:~/centos-charms/model-prep$ cat centos-model.yaml 
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
"
echo "juju model-config centos-model.yaml"
echo ""
export CHARM_LAYERS_DIR=~/centos-charms/layers/
charm build . -w ./wheelhouse-overrides.txt
