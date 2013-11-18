class wh_firewall::post {
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
}
