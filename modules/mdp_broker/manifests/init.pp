class mdp_broker($production = false){
	$service_name = 'mdp_broker'
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
		unless => '/usr/bin/test -d /root/go/src/github.com/wurkhappy/mdp',
	}
	exec{'/usr/local/go/bin/go install -o mdp_broker':
		refreshonly => true,
			    cwd => '/root/go/src/github.com/wurkhappy/mdp/broker',
	}
}
