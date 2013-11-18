class basic_pkgs{
	package{'gcc':
		ensure => installed,
	}
	package{ 'autoconf':
		ensure => installed,
	}
	package{'make':
		ensure => installed,
	}
	package{ 'wget':
		ensure => installed,
	}
}
