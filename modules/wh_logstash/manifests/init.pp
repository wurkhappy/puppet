class wh_logstash{
	class { 'logstash':
   java_install => true
 }
 logstash::configfile { 'input_lj':
   file  => 'puppet:///modules/wh_logstash/input_lj',
   order   => 10,
 }
  logstash::configfile { 'output':
   sou  => 'puppet:///modules/wh_logstash/output',
   order   => 20,
 }
}