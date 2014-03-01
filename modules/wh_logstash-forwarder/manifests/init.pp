class wh_logstash-forwarder{
	class { 'logstashforwarder':
	servers  => [ 'localhost:33333' ],
	ssl_key  => '/etc/puppet/logstash-forwarder.key',
	ssl_ca   => '/etc/puppet/logstash-forwarder.crt',
	ssl_cert => '/etc/puppet/logstash-forwarder.crt',
}
logstashforwarder::file { 'nginx':
paths  => [ '/var/log/nginx/*.log' ],
fields => { 'type' => 'nginx' },
}
}