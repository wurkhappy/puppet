class{'nginx':}
->
nginx::resource::upstream { '${hostname}.${domain}':
                ensure  => present,
                members => [
                        '127.0.0.1:4000',
                ],
       }

file{"/etc/nginx/sites-available/wurkhappy.com":
ensure =>'file',
content => template('nginx_conf.erb'),
mode => 0750,
require => Class["nginx"],
}
exec{"/bin/ln -s /etc/nginx/sites-available/wurkhappy.com.conf /etc/nginx/sites-enabled/wurkhappy.com.conf":
require => File["/etc/nginx/sites-available/wurkhappy.com"],
}
exec{"/sbin/service nginx restart":
subscribe => Exec["/bin/ln -s /etc/nginx/sites-available/wurkhappy.com.conf /etc/nginx/sites-enabled/wurkhappy.com.conf"],
}
