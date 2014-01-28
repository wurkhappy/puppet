define wh_service ($service_name, $production = false){
	file{'/service':
	ensure => 'directory',
}
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
unless => ["/usr/bin/test -d /home/wh/${service_name}"],
cwd => '/home/wh',
}

}

