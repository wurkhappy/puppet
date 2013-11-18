class users {
	file { "/etc/sudoers":
		owner => root,
		      group => root,
		      mode => 440,
		      source => 'puppet:///modules/users/sudoers',
	}	
	group { "admin":
		ensure => "present",
	}
	user { 'enoch':
		ensure => 'present',
		       groups => ['admin'],
		       home => '/home/enoch',
		       managehome => true,
		       shell => '/bin/bash',
		       require => Group['admin'],
		       password => '$6$rEtxeK9G$CEGe9oX7WPgHeXyjVHUqXmoQx/1F.jRycWkEn2magcOBfs0e/uG3Ccj22clLUN7eyXDV2X.jmq.a03xA3o6ZC1',
	}
	ssh_authorized_key { 'enoch_ssh':
		user => 'enoch',
		     type => 'rsa',
		     key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCgGmXqPDimh7PnpNWB6DfwMP2MaCf0d0gGAyJpcW788Z92E7uJpb+qzAuYY1MHwxRoNx5o+038kAycAMJZQ84zHPTF4ZYUdpZd6nmijshaMxp1KrcmXzy7esRhRceVzr3qxb8jcVk0nCb7TCsvtEfuB+apZlqwvO3V/q8IDtf435haBUomRM9e5Gkd4zwgl3Hki14BXAK4DHe+NZKcTHgmNSvBUxrQmKPPjj0X4lMzzYQ9gDXxQM5iVCJh5vFoEY/zqa4QcGVyFSuRyuZ9zO0hYKHnSg1XMlXO0UYHLTY6HYtMasXUcVchvm9rcwHWsjSluTJJlgXwCXPUOvMm0COF'
	}
	user { 'root':
		ensure           => 'present',
				 comment          => 'root',
				 gid              => '0',
				 groups           => ['root', 'bin', 'daemon', 'sys', 'adm', 'disk', 'wheel'],
				 home             => '/root',
				 password         => '$6$WpW1hqf1SMAGoRph$UKXMVNxkp/oUdZyEbm704CHL2Cmo5Fp1IdmiwJSPUB.cQuPX8OPEuZPuV/Rds1tBm3rbnps8x5Wr8Ot8dCR5E.',
				 password_max_age => '99999',
				 password_min_age => '0',
				 shell            => '/bin/bash',
				 uid              => '0',
	}
}
