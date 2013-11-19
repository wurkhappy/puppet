class golang {
	exec { '/usr/bin/wget http://go.googlecode.com/files/go1.2rc5.linux-amd64.tar.gz':
		unless => ["/usr/bin/test -d /usr/local/go"],
		       notify => Exec['/bin/tar -C /usr/local -xzf go1.2rc5.linux-amd64.tar.gz'],
	}
	exec{ '/bin/tar -C /usr/local -xzf go1.2rc5.linux-amd64.tar.gz':
		refreshonly => true,
	}
	file_line{'golang paths':
		ensure => present,
		       line => 'export PATH=$PATH:/usr/local/go/bin',
		       path => '/etc/profile',
		       notify => Exec['/bin/bash -c "source /etc/profile"'],
	}
	exec{ '/bin/bash -c "source /etc/profile"':
		refreshonly => true,
	}
	file{['/root/go','/root/go/src']:
		ensure => directory,
	}
}
