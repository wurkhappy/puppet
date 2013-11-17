class wal_e::pg_conf{
	postgresql::server::config_entry { 'wal_level':
		value => 'archive',
	}
	postgresql::server::config_entry { 'archive_mode':
		value => 'on',
	}
	postgresql::server::config_entry { 'archive_command':
		value => '/package/admin/daemontools-0.76/command/envdir /etc/wal-e.d/env wal-e wal-push %p',
	}
	postgresql::server::config_entry { 'archive_timeout':
		value => '60',
	}
}

