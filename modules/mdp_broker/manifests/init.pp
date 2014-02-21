class mdp_broker($production = false){
	$service_name = 'mdp/mdp_broker'
		file{'/service/mdp_broker':
			ensure => 'directory',
		}
	file{'/service/mdp_broker/run':
		ensure => 'file',
		       mode => 0750,
		       content => template('wh_service/service_run.erb'),
	}
	file{'/service/mdp_broker/log':
		ensure => 'directory',
	}
	file{'/service/mdp_broker/log/run':
		ensure => 'file',
		       mode => 0750,
		       content => template('wh_service/service_log_run.erb'),
	}
	exec{'/usr/bin/git clone git@github.com:wurkhappy/mdp.git':
		unless => '/usr/bin/test -d /home/wh/mdp',
	}
}
