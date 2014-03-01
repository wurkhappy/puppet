class wh_logstash_forwarder{
	file{'/home/wh/logstash-forwarder': 
	content => "puppet:///modules/wh_logstash_forwarder/logstash-forwarder",
	ensure=> file,
	owner => "wh",
	mode => 0544,
}
file{'/home/wh/config.conf': 
content => "puppet:///modules/wh_logstash_forwarder/config.conf",
ensure=> file,
owner => "wh",
mode => 0444,
}
file{'/service':
ensure => 'directory',
}
file{"/service/logstash-forwarder":
ensure => 'directory',
}
file{"/service/logstash-forwarder/run":
ensure =>'file',
content => 'puppet:///modules/wh_logstash_forwarder/service_run'),
mode => 0750,
}
file{"/service/logstash-forwarder/log":
ensure =>'directory',
}
file{"/service/logstash-forwarder/log/run":
ensure =>'file',
content => 'puppet:///modules/wh_logstash_forwarder/service_log_run'),
mode => 0750,
}
}
