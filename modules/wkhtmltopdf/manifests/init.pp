class wkhtmltopdf{
	package{'urw-fonts':
		ensure => installed,
	}
	package{'libXext':
		ensure => installed,
	}
	package{'openssl-devel':
		ensure => installed,
	}	
	exec { '/usr/bin/wget https://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.11.0_rc1-static-amd64.tar.bz2':
		unless => ["/usr/bin/test -f /usr/local/bin/wkhtmltopdf"],
		       notify => Exec['/bin/tar -C /usr/local/bin -jxzf wkhtmltopdf-0.11.0_rc1-static-amd64.tar.bz2'],
	}
	exec{ '/bin/tar -C /usr/local/bin -jxzf wkhtmltopdf-0.11.0_rc1-static-amd64.tar.bz2':
		refreshonly => true,
			    notify => [Exec['/bin/mv /usr/local/bin/wkhtmltopdf-amd64 /usr/local/bin/wkhtmltopdf'],Exec['/bin/rm wkhtmltopdf-0.11.0_rc1-static-amd64.tar.bz2']],
	}
	exec{'/bin/mv /usr/local/bin/wkhtmltopdf-amd64 /usr/local/bin/wkhtmltopdf':
		refreshonly => true,
	}
	exec{'/bin/rm wkhtmltopdf-0.11.0_rc1-static-amd64.tar.bz2':
		refreshonly => true,
	}
}
