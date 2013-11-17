class wal_e($aws_secret, $aws_key, $prefix){
	class{'wal_e::install':}		
	class{'wal_e::setup':
		aws_secret => $aws_secret,
			   aws_key => $aws_key,
			   prefix => $prefix,
			   require => Class['wal_e::install'],
	}
	class{'wal_e::pg_conf':}
	exec{'backup':
		command => '/package/admin/daemontools-0.76/command/envdir /etc/wal-e.d/env wal-e backup-push /var/lib/pgsql/9.3/data',		
			user => 'postgres',
			refreshonly => true,
			require => Class['wal_e::pg_conf'],
	}
}
