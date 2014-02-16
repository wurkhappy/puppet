stage { 'run_app':}
Stage['main'] -> Stage['run_app']

##Stage Tools
class{"wh_nginx":}
class{'zeromq':}
class { 'redis':
	version => '2.6.16',
}

exec{'main-config':
command => '/usr/bin/git clone git@github.com:wurkhappy/WH-Config.git',
cwd => '/home/wh',
unless => ['/usr/bin/test -d /home/wh/WH-Config'],
}

wh_service{'WH-WebApp':
service_name => 'WH-WebApp',
production => true,
require => Exec['main-config'],
}

package{'gcc':
ensure => installed,
}
class{'daemontools':
stage => 'run_app',
require => Package['gcc'],
}

