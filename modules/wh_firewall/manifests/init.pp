class wh_firewall{
	resources { "firewall":
		purge => true
	}
	Firewall {
		before  => Class['wh_firewall::post'],
			require => Class['wh_firewall::pre'],
	}
	class { ['wh_firewall::pre', 'wh_firewall::post']: }
	class { 'firewall': }
}
