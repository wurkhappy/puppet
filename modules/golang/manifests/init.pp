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
		       notify => Exec['/etc/profile.d/golang.sh'],
	}
	file_line{'gopath':
		ensure => present,
		       line => 'export GOPATH=/root/go',
		       path => '/etc/profile.d/golang.sh',
		       notify => Exec['/etc/profile.d/golang.sh'],
	}
	file{'/etc/profile.d/golang.sh':
		ensure => 'file',
		       mode => 0750,
	}
	exec{ '/etc/profile.d/golang.sh':
command => "/bin/bash -c '/etc/profile.d/golang.sh'",	
refreshonly => true,
	}
	file{['/root/go','/root/go/src']:
		ensure => directory,
	}
}
