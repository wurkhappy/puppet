stage { 'first': 
        before => Stage['main'],
}
class{'basic_pkgs':
        stage=> first,
}
include users
class { 'timezone':
        region => 'Etc',
               locality => 'UTC',
}
include ssh
include wh_firewall
cron{'sync_puppet':
        ensure => present,
               command => 'cd /etc/puppet/ && /usr/bin/git pull origin master && /usr/bin/puppet apply /etc/puppet/manifests/dbserver.pp --modulepath=/etc/puppet/modules',
               hour => '*',
               minute => [0,30],
}

class {'epel':}
->
include '::rabbitmq'
rabbitmq_plugin {'rabbitmq_admin':
  ensure => present,
}
include zeromq
