class wh_nginx{
class{'nginx':}
nginx::resource::upstream { "wurkhappy.com":
                ensure  => present,
                members => [
                        '127.0.0.1:4000',
                ],
       }

file{"/etc/nginx/sites-available/wurkhappy.com":
ensure =>'file',
content => template('wh_nginx/nginx_conf.erb'),
mode => 0750,
}
exec{"/bin/ln -s /etc/nginx/sites-available/wurkhappy.com /etc/nginx/sites-enabled/wurkhappy.com":
subscribe => File["/etc/nginx/sites-available/wurkhappy.com"],
}
exec{"/sbin/service nginx restart":
subscribe => Exec["/bin/ln -s /etc/nginx/sites-available/wurkhappy.com /etc/nginx/sites-enabled/wurkhappy.com"],
}
}