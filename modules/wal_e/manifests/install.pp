class wal_e::install{
	include daemontools
		class {'rpmforge':
			extras => 1,
		}
	package{ 'pv':
		ensure => installed,
		       require => Class['rpmforge'],
	}
	package{'lzop':
		ensure => installed,
	}
	package{'python-pip':
		ensure => installed,
		       require =>[Package['epel-release-6-8'],Package['python-setuptools']], 
	}
	package{'wal-e':
		provider => 'pip',
			 ensure => installed,
			 require => [Package['python-pip'],Package[ 'lzop'],Package[ 'pv'], Package['gcc'],Package['libevent-devel']],
	}
	package{'epel-release-6-8':
		provider => 'rpm',
			 ensure => installed,
			 source => 'http://mirror-fpt-telecom.fpt.net/fedora/epel/6/i386/epel-release-6-8.noarch.rpm',
	}
	package{'python-setuptools':
		ensure => installed,
	}
	package{'python-devel':
		ensure => installed,
	}
	package{'libevent-devel':
		ensure => installed,
	}

}

