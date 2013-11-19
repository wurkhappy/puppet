class service ($service_name){

	file{"/service/${service_name}":
		ensure => 'directory',
	}
	file{"/service/${service_name}/run":
		ensure =>'file',
		       content => template('service/service_run.erb'),
		       mode => 0750,
	}
	file{"/service/${service_name}/log":
		ensure =>'directory',
	}
	file{"/service/${service_name}/log/run":
		ensure =>'file',
		       content => template('service/service_log_run.erb'),
		       mode => 0750,
	}

}

