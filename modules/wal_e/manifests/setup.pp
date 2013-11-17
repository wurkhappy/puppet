class wal_e::setup($aws_secret, $aws_key, $prefix) inherits wal_e{
	file{'/etc/wal-e.d':
		ensure => 'directory',
	}	
	file{'/etc/wal-e.d/env':
		ensure => 'directory',
		       recurse => true,
		       owner => 'postgres',
		       group => 'postgres',
	}
	file{'/etc/wal-e.d/env/AWS_SECRET_ACCESS_KEY':
		content => $aws_secret,
			ensure=> file,
	}
	file{'/etc/wal-e.d/env/AWS_ACCESS_KEY_ID': 
		content => $aws_key,
			ensure=> file,
			notify => Exec['backup'],
	}
	file{'/etc/wal-e.d/env/WALE_S3_PREFIX':
		content => $prefix,	
			ensure=> file,
			notify => Exec['backup'],
	}

}
