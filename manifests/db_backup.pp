class {'wal_e':
	aws_secret => 'AjXuRHERUitgPwaLKgc3ERlsQQt0fIvUWCJk4eAz',
		   aws_key => 'AKIAI2PQ6CTNJJAUMV3Q',
		   prefix => 's3://wh-pg-backups',
}
cron{ 'db_backup':
	user => 'postgres',
	     ensure => present,
	     command => '/package/admin/daemontools-0.76/command/envdir /etc/wal-e.d/env wal-e backup-push /var/lib/pgsql/9.3/data',		
	     hour => 2,
	     minute => 0,
}