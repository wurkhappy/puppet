class ssh{
	service{ 'sshd':
		ensure => running,
		binary => '/usr/sbin/sshd',
	}
	file{ '/etc/ssh/sshd_config':
		source => 'puppet:///modules/ssh/sshd_config',
		       notify => Service['sshd'],
		       owner => 'root',
		       group => 'root',
	}
}
