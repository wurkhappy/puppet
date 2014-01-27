# Class: email::commands
#
#
class email::commands {
	exec{"postmap /etc/postfix/virtual":
	path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ]
}
->
exec{"touch /etc/postfix/body_checks":
unless => ["/usr/bin/test -f /etc/postfix/body_checks"],
path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ]
}
}