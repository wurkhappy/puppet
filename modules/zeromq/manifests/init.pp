class zeromq {
	file{'/etc/yum.repos.d/home-fengshuo-zeromq.repo':
		ensure => 'file',
		       source => 'puppet:///modules/zeromq/home-fengshuo-zeromq.repo',
	}
	->
		package {'zeromq':
			ensure => installed,
		}
}
