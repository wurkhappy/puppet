stage { 'tools':
before => Stage['main'],
}

##Stage Tools
class {'epel':
stage => 'tools',
}
->
package{'erlang':
	ensure => installed,
	stage => 'tools',
}
->
class{'rabbitmq':
stage => 'tools',
}
class{'zeromq':
stage => 'tools',
}


exec{'main-config':
	command => '/usr/bin/git clone git@github.com:wurkhappy/WH-Config.git',
		cwd => '/home/wh',
		unless => ['/usr/bin/test -d /home/wh/WH-Config'],
}

wh_service{'WH-Agreements':
	service_name => 'WH-Agreements',
		     production => true,
}