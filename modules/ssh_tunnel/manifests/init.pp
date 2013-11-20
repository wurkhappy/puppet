define ssh_tunnel($local_port, $foreign_port, $foreign_ip){
	$service_name = "ssh_tunnel_${local_port}"
		$service_path = "/service/${service_name}"
		file{$service_path:
			ensure => 'directory',
		}
	file{"${service_path}/run":
		ensure => 'file',
		       mode => 0750,
		       content => template('ssh_tunnel/service_run.erb'),
	}
	file{"${service_path}/log":
		ensure => 'directory',
	}
	file{"${service_path}/log/run":
		ensure => 'file',
		       mode => 0750,
		       content => template('wh_service/service_log_run.erb'),
		       notify => Exec["/usr/local/bin/svc -u /service/${service_name}"],
	}
	exec{"/usr/local/bin/svc -u /service/${service_name}":
		refreshonly => true,
	}

}
