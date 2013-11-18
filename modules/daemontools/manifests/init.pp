class daemontools{
	exec { '/etc/puppet/modules/daemontools/files/install.sh':
		unless => ["/usr/bin/test -f /package/admin/daemontools-0.76/command/envdir"],
		       notify => Exec['/sbin/initctl reload-configuration'],
	}
	exec{ '/sbin/initctl reload-configuration':
		refreshonly => true,		
			    notify => Service['svscan'],
	}
	service{'svscan':
		ensure => 'running',
		       hasrestart => true,
		       hasstatus => true,
		       restart => '/sbin/initctl restart svscan',
		       start => '/sbin/initctl start svscan',
		       stop => '/sbin/initctl stop svscan',
		       status => '/sbin/initctl status svscan | grep "/running" 1>/dev/null 2>&1',
	}
}
