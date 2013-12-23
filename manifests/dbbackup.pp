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
class{'wal_e::install':}
class{'wal_e::setup':
	aws_secret => 'AjXuRHERUitgPwaLKgc3ERlsQQt0fIvUWCJk4eAz',
		   aws_key => 'AKIAI2PQ6CTNJJAUMV3Q',
		   prefix => 's3://wh-pg-backups',
                           require => Class['wal_e::install'],
        }
exec{'backup':
                command => '/bin/echo -',
                        user => 'postgres',
                        refreshonly => true,
        }
include wh_firewall

cron{'sync_puppet':
	ensure => present,
	       command => 'cd /etc/puppet/ && /usr/bin/git pull origin master && /usr/bin/puppet apply /etc/puppet/manifests/dbbackup.pp --modulepath=/etc/puppet/modules',
	       hour => '*',
	       minute => [0,30],
}

