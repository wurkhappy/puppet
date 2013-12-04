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
firewall { '504 inbound web':
	proto    => 'tcp',
		 dport => 4000,
		 action => 'accept',
}
firewall { '505 outbound 4000':
	chain => 'OUTPUT',
	      proto    => 'tcp',
	      sport => 4000,
	      action => 'accept',
}


cron{'sync_puppet':
	ensure => present,
	       command => 'cd /etc/puppet/ && /usr/bin/git pull origin master && /usr/bin/puppet apply /etc/puppet/manifests/webapp.pp --modulepath=/etc/puppet/modules',
	       hour => '*',
	       minute => [0,30],
}
include daemontools
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

class{'epel':}
->
class{'nodejs':}
->
package { 'bower':
	ensure   => installed,
		 provider => 'npm',
		 notify => Exec['webapp bower'],
}
exec{'webapp bower':
	command => 'bower install',
		cwd => '/root/go/src/github.com/wurkhappy/WH-WebApp',
		path => '/sbin',
		refreshonly => true,
}
ssh_tunnel{'rabbitmq-broker':
	local_port => 5672,
		   foreign_port => 5672,
		   foreign_ip => 'tunnel@192.168.139.151',
}

