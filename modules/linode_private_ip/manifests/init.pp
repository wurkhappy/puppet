class linode_private_ip($priv_address){
	file{"/etc/sysconfig/network-scripts/ifcfg-eth0:1":
	ensure => 'file',
	mode => 0750,
	content => template('linode_private_ip/ifconfig.erb'),
}
exec{'/sbin/service network restart':
subscribe => File["/etc/sysconfig/network-scripts/ifcfg-eth0:1"],
refreshonly => true,
}
}