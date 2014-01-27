class email::config {
	file{"/etc/postfix/main.cf":
	ensure =>'file',
	content => template('email/postfix_main.erb'),
	mode => 0700,
}
file{"/etc/postfix/virtual":
ensure =>'file',
content => "enoch@${hostname}.wurkhappy.com   enoch\@${hostname}.wurkhappy.com",
mode => 0700,
}
file{"/etc/sasl2/smtpd.conf":
ensure =>'file',
content => 'pwcheck_method: auxprop
auxprop_plugin: sasldb
mech_list: PLAIN LOGIN CRAM-MD5 DIGEST-MD5',
mode => 0700,
}
file{"/etc/imapd.conf":
ensure =>'file',
content => template('email/imapd.erb'),
mode => 0700,
}
}