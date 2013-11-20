define wh_service ($service_name, $production = false){

	file{"/service/${service_name}":
		ensure => 'directory',
	}
	file{"/service/${service_name}/run":
		ensure =>'file',
		       content => template('wh_service/service_run.erb'),
		       mode => 0750,
	}
	file{"/service/${service_name}/log":
		ensure =>'directory',
	}
	file{"/service/${service_name}/log/run":
		ensure =>'file',
		       content => template('wh_service/service_log_run.erb'),
		       mode => 0750,
	}
	exec{"/usr/bin/git clone git@github.com:wurkhappy/${service_name}.git":
		unless => ["/usr/bin/test -d /root/go/src/github.com/wurkhappy/${service_name}"],
		       cwd => '/root/go/src/github.com/wurkhappy',
		       notify => Exec["${service_name}deps"],
	}
	exec{"${service_name}deps":
		command => "/usr/local/go/bin/go get ./...",
			cwd => "/root/go/src/github.com/wurkhappy/${service_name}",
			refreshonly => true,
		       notify => Exec["${service_name}install"],
	}
	exec{"${service_name}install":
		command => "/usr/local/go/bin/go install",
			cwd => "/root/go/src/github.com/wurkhappy/${service_name}",
			refreshonly => true,
	}

}

