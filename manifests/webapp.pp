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
               command => 'cd /etc/puppet/ && /usr/bin/git pull origin master && /usr/bin/puppet apply /etc/puppet/manifests/webapp.pp --modulepath=/etc/puppet/modules',
               hour => '*',
               minute => [0,30],
}

include zeromq
class{'golang':}
->
exec{'main-config':
command => '/usr/bin/git clone git@github.com:wurkhappy/WH-Config.git',
        cwd => '/root/go',
            unless => ['/usr/bin/test -d /root/go/WH-Config'],
}

file{'/service':
        ensure => 'directory',
}

file{'/root/go/src/github.com':
ensure =>'directory',
}
->
file{'/root/go/src/github.com/wurkhappy':
ensure => 'directory',
}
->
wh_service::helper{'mdp':
        repo => 'mdp',
}
->
wh_service::helper{'WH-Config':
        repo => 'WH-Config',
}
wh_service{'WH-WebApp':
        service_name => 'WH-WebApp',
                     production => true,
                     require => File['/service'],
}
class { 'redis':
  version => '2.6.16',
}
