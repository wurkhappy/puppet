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
class{"linode_private_ip":
priv_address => "192.168.139.69",
}

ssh_tunnel{'broker':
local_port => 5555,
foreign_port => 5555,
foreign_ip => 'tunnel@192.168.139.151',
require => Class["linode_private_ip"],
}

ssh_tunnel{'rabbitmq-broker':
local_port => 5672,
foreign_port => 5672,
foreign_ip => 'tunnel@192.168.139.151',
require => Class["linode_private_ip"],
}

class{'daemontools':
stage => 'run_app',
require => Package['gcc'],
}

include wh_firewall
firewall { '500 inbound web':
	proto    => 'tcp',
		 dport => 443,
		 action => 'accept',
}
firewall { '501 outbound 4000':
	chain => 'OUTPUT',
	      proto    => 'tcp',
	      sport => 443,
	      action => 'accept',
}
firewall { '502 inbound web':
	proto    => 'tcp',
		 dport => 80,
		 action => 'accept',
}
firewall { '503 outbound 4000':
	chain => 'OUTPUT',
	      proto    => 'tcp',
	      sport => 80,
	      action => 'accept',
}

