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
file{ '/home/tunnel/.ssh/tunnel_rsa':
source => 'puppet:///modules/ssh/tunnel_rsa',
owner => 'tunnel',
group => 'tunnel',
mode => 0700,
}
file{'/home/tunnel/.ssh/config':
ensure => present,
}
file_line{'tunnel_ident':
ensure => present,
line => 'IdentityFile /home/tunnel/.ssh/tunnel_rsa',
path => '/home/tunnel/.ssh/config',
}
}
