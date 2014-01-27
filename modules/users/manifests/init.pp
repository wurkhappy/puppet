class users {
	file { "/etc/sudoers":
		owner => root,
		      group => root,
		      mode => 440,
		      source => 'puppet:///modules/users/sudoers',
	}
	#admin is a group that gives sudoers power	
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
	#tunnel is purely for the purpose of tunneling
	user { 'tunnel':
		ensure => 'present',
		       home => '/home/tunnel',
		       managehome => true,
		       shell => '/bin/bash',
	}
	#wh is purely for the purpose of running wurkhappy apps/services
	user { 'wh':
		ensure => 'present',
		       home => '/home/wh',
		       managehome => true,
		       shell => '/bin/bash',
		       password => '$1$ihlrowCw$FnaHyUweev1yv/vdvDi4x.',
	}
	ssh_authorized_key { 'enoch_ssh':
		user => 'enoch',
		     type => 'rsa',
		     key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCgGmXqPDimh7PnpNWB6DfwMP2MaCf0d0gGAyJpcW788Z92E7uJpb+qzAuYY1MHwxRoNx5o+038kAycAMJZQ84zHPTF4ZYUdpZd6nmijshaMxp1KrcmXzy7esRhRceVzr3qxb8jcVk0nCb7TCsvtEfuB+apZlqwvO3V/q8IDtf435haBUomRM9e5Gkd4zwgl3Hki14BXAK4DHe+NZKcTHgmNSvBUxrQmKPPjj0X4lMzzYQ9gDXxQM5iVCJh5vFoEY/zqa4QcGVyFSuRyuZ9zO0hYKHnSg1XMlXO0UYHLTY6HYtMasXUcVchvm9rcwHWsjSluTJJlgXwCXPUOvMm0COF',
	}
	#allows other servers to create a tunnel with the current server
	ssh_authorized_key { 'tunnel_ssh':
		user => 'tunnel',
		     type => 'rsa',
		     key  => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAwSUmi9tXfCIBust96CCCTZEtXNj/gC6OR9VgO36o0mATq00Tvm0Q5mglgyXbbHMF+fWA3Xl0FLHK+TpDDILRk1FzhAc+u7Ecks8aYnoIThNv26E0zYTen+YjHQVeWPHoM42SnEkLKsDDJpII+Xqc7aH6Ksd3w75lT3tKUYQ8n0NAjCQDoX+8qpgGPqp2oxsozsYjiQeIAqIuQrSt/hrSdeGRzT4F/OKbw2nRfTxAYkvH7U+/c22WDIe6QEqaComFxHtCKOsyW0pd7y/kFVj69r/6UvLYujgcSsopEmR3bOu3/lZBc8ODyW3gC+plIveQptAeMkNVKvjoLnzsdfx/8w==',
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
