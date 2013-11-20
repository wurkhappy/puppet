define wh_service::helper($repo){
	exec{"/usr/bin/git clone git@github.com:wurkhappy/${repo}.git":
		unless => ["/usr/bin/test -d /root/go/src/github.com/wurkhappy/${repo}"],
		       cwd => '/root/go/src/github.com/wurkhappy',
	}
}
