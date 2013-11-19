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
include golang
