class wh_firewall::pre {
	Firewall {
		require => undef,
	}
	firewall { '000 inbound ssh from vpn':
		proto    => 'tcp',
			 source   => '69.164.222.213',
			 dport => 22,
			 action => 'accept',
	}
	firewall { '001 outbound ssh to vpn':
		chain => 'OUTPUT',
		      proto    => 'tcp',
		      destination   => '69.164.222.213',
		      sport => 22,
		      action => 'accept',
	}
	firewall { '002 inbound established udp':
		proto    => 'udp',
			 state   => ['ESTABLISHED'],			 
			 action => 'accept',
	}
	firewall { '003 outbound udp':
		chain => 'OUTPUT',		
		      proto    => 'udp',
		      state   => ['NEW','ESTABLISHED'],			 
		      action => 'accept',
	}
	firewall { '004 accept all icmp':
		proto   => 'icmp',
			action  => 'accept',
	}
	firewall { '005 accept all outbound icmp':
		chain=> 'OUTPUT',
			proto   => 'icmp',
			action  => 'accept',
	}
	firewall { '006 accept established tcp':
		proto    => 'tcp',
			 iniface => 'eth0',			 
			 state   => ['ESTABLISHED'],			 
			 action => 'accept',
	}
	firewall { '007 allow outbound tcp':
		chain => 'OUTPUT',		
		      proto    => 'tcp',
		      outiface => 'eth0',
		      state   => ['NEW','ESTABLISHED'],			 
		      action => 'accept',
	}
	firewall { '008 allow localhost outbound':
		chain => 'OUTPUT',
		      proto => 'tcp',
		      destination => '127.0.0.1',
		      action => 'accept',
	}

}
