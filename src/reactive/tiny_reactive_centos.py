from charms.reactive import when, when_not, set_flag
from charmhelpers.core.hookenv import (
    status_set,
    log,
)

#
# CENTOS
#

@when_not('tiny-reactive-centos.installed')
def install_tiny_reactive_centos():

    set_flag('tiny-reactive-centos.installed')

@when('tiny-reactive-centos.installed')
def done():
    log("CENTOS DEPLOYED")
    status_set('active', 'Ready: centos')
