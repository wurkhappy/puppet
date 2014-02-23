stage { 'run_app':}
Stage['main'] -> Stage['run_app']

class{'zeromq':}

exec{'main-config':
command => '/usr/bin/git clone git@github.com:wurkhappy/WH-Config.git',
cwd => '/home/wh',
unless => ['/usr/bin/test -d /home/wh/WH-Config'],
}

wh_service{'WH-Comments':
service_name => 'WH-Comments',
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