stage { 'run_app':}
Stage['main'] -> Stage['run_app']

class{'zeromq':}

exec{'main-config':
command => '/usr/bin/git clone git@github.com:wurkhappy/WH-Config.git',
cwd => '/home/wh',
unless => ['/usr/bin/test -d /home/wh/WH-Config'],
}

class{'wkhtmltopdf':}

wh_service{'PDFService':
service_name => 'PDFService',
production => true,
require => [Exec['main-config'], Class["wkhtmltopdf"]],
}

package{'gcc':
ensure => installed,
}
class{'daemontools':
stage => 'run_app',
require => Package['gcc'],
}