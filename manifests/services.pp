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
	       command => 'cd /etc/puppet/ && /usr/bin/git pull origin master && /usr/bin/puppet apply /etc/puppet/manifests/services.pp --modulepath=/etc/puppet/modules',
	       hour => '*',
	       minute => [0,30],
}

class {'epel':}
->
package{'erlang':
	ensure => installed,
}
firewall { '500 allow outbound for lo':
#for rabbitmq
	chain => 'OUTPUT',
	      source => '23.92.20.137',		
	      proto    => 'tcp',
	      outiface => 'lo',
	      action => 'accept',
}
->
firewall { '501 allow inbound for lo':
#for rabbitmq
	source => '23.92.20.137',		
	       proto    => 'tcp',
	       iniface => 'lo',
	       action => 'accept',
}


->
class{'rabbitmq':}
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
wh_service{'WH-Agreements':
	service_name => 'WH-Agreements',
		     production => true,
		     require => File['/service'],
}
wh_service{'WH-Comments':
	service_name => 'WH-Comments',
		     production => true,
		     require => File['/service'],
}
wh_service{'WH-Email':
	service_name => 'WH-Email',
		     production => true,
		     require => File['/service'],
}
wh_service{'WH-PaymentInfo':
	service_name => 'WH-PaymentInfo',
		     production => true,
		     require => File['/service'],
}
wh_service{'WH-Transactions':
	service_name => 'WH-Transactions',
		     production => true,
		     require => File['/service'],
}
wh_service{'WH-UserService':
	service_name => 'WH-UserService',
		     production => true,
		     require => File['/service'],
}
wh_service::helper{'Rabbitmq-go-wrapper':
	repo => 'Rabbitmq-go-wrapper',
}
wh_service::helper{'Balanced-go':
	repo => 'Balanced-go',
}
wh_service::helper{'mandrill-go':
	repo => 'mandrill-go',
}
wh_service::helper{'WH-Config':
	repo => 'WH-Config',
}
class{'wkhtmltopdf':}
->
wh_service{'PDFService':
	service_name => 'PDFService',
		     production => true,
		     require => File['/service'],
}

class{'mdp_broker':
	production => true,
}
ssh_tunnel{'postgres':
	local_port => 5432,
		   foreign_port => 5432,
		   foreign_ip => 'tunnel@192.168.139.152',
}
ssh_tunnel{'webapp_redis':
	local_port => 6379,
		   foreign_port => 6379,
		   foreign_ip => 'tunnel@192.168.139.69',
}

