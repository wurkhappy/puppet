include users
class { 'timezone':
	region => 'Etc',
	       locality => 'UTC',
}
include ssh
class { 'postgresql::globals':
	manage_package_repo => true,
			    version             => '9.3',
}->
class { 'postgresql::server':
	ip_mask_deny_postgres_user => '0.0.0.0/32',
				   ip_mask_allow_all_users    => '0.0.0.0/0',
				   listen_addresses           => '*',
				   postgres_password          => 'wh!coll@b',
}
postgresql::server::role { 'wurkhappy':
	password_hash => postgresql_password('wurkhappy', 'whcollab'),
}
postgresql::server::db { 'wurkhappy':
	user     => 'wurkhappy',
		 password => postgresql_password('wurkhappy', 'whcoll@b'),
}
class {'wal_e':
	aws_secret => 'AjXuRHERUitgPwaLKgc3ERlsQQt0fIvUWCJk4eAz',
		   aws_key => 'AKIAI2PQ6CTNJJAUMV3Q',
		   prefix => 's3://wh-pg-backups',
}
include wh_firewall
