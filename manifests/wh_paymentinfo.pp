stage { 'run_app':}
Stage['main'] -> Stage['run_app']

class{'zeromq':}

exec{'main-config':
command => '/usr/bin/git clone git@github.com:wurkhappy/WH-Config.git',
cwd => '/home/wh',
unless => ['/usr/bin/test -d /home/wh/WH-Config'],
}

wh_service{'WH-PaymentInfo':
service_name => 'WH-PaymentInfo',
production => true,
require => Exec['main-config'],
}

ssh_tunnel{'db':
local_port => 5432,
foreign_port => 5432,
foreign_ip => 'tunnel@192.168.139.152',
}

package{'gcc':
ensure => installed,
}
class{'daemontools':
stage => 'run_app',
require => Package['gcc'],
}