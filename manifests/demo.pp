# demo.pp
package { "nginx":
    ensure => installed
}

service { "nginx":
    require => Package["nginx"],
    ensure => running,
    enable => true
}
file { "/usr/share/nginx/html":
    ensure => "directory"
}

file { "/etc/nginx/sites-available/":
    ensure => "directory"
}

file { "/etc/nginx/sites-enabled/":
    ensure => "directory"
}

file { "/usr/share/nginx/html/index.html":
    require => File["/usr/share/nginx/html"],
    ensure => present,
    content => "<!DOCTYPE html>
        <html><body>
        Hello, world.
        "
}

file { "/etc/nginx/sites-available/puppet-demo":
    require => [
        Package["nginx"],
        File["/usr/share/nginx/html"],
	File["/etc/nginx/sites-available/"]
    ],
    ensure => "file",
    content => 
        "server {
            listen 80 default_server;
            server_name _;
            location / { root /usr/share/nginx/html; }
        }",
    notify => Service["nginx"]
}

file { "/etc/nginx/sites-enabled/puppet-demo":
    require => [
	File["/etc/nginx/sites-available/puppet-demo"],
	File["/etc/nginx/sites-enabled/"]
    ],
    ensure => "link",
    target => "/etc/nginx/sites-available/puppet-demo",
    notify => Service["nginx"]
}
