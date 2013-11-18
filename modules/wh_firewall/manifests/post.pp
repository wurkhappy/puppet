class wh_firewall::post {
	firewall { '996 log dropped inbound':
		limit => '2/min',
		      jump => 'LOG',
		      log_level => 7,
		      log_prefix =>"Dropped by firewall: ",
		      before => undef,
	}
	firewall { '997 log dropped outbound':
		chain => 'OUTPUT',
		      limit => '2/min',
		      jump => 'LOG',
		      log_level => 7,
		      log_prefix =>"Dropped outbound: ",
		      before => undef,
	}
	firewall { '998 drop outbound':
		chain => 'OUTPUT',    
		      proto   => 'all',
		      action  => 'drop',
		      before  => undef,
	}
	firewall { '999 drop all':
		proto   => 'all',
			action  => 'drop',
			before  => undef,
	}
	file_line{'firewall logging':
		ensure => present,
		       line => 'kern.=debug     /var/log/firewall',
		       path => '/etc/rsyslog.conf',
		       notify => Exec['log restart'],
	}
	exec{'log restart':
		command => '/sbin/service rsyslog restart',
			refreshonly => true,
	}

}
