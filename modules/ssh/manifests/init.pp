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
	file{ '/root/.ssh/tunnel_rsa':
		source => 'puppet:///modules/ssh/tunnel_rsa',
		       owner => 'root',
		       group => 'root',
	}
	file_line{'tunnel_ident':
		ensure => present,
		       line => 'IdentityFile ~/.ssh/tunnel_rsa',
		       path => '/root/.ssh/config',
	}
}
