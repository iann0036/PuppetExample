class apacheexample {
	case $operatingsystem {
		'CentOS', 'RedHat': {
			package { 'httpd':
				name   => "httpd",
				ensure => true,
			}
			package { 'mod_ssl':
				name => "mod_ssl",
				ensure => true,
				require => Package['httpd'],
				notify => Service['httpd'],
			}
			service { 'httpd':
				ensure => true,
				enable => true,
				require => Package['httpd'],
			}
			file { "httpd.conf":
				path   => "/etc/httpd/conf/httpd.conf",
				owner  => root,
				group  => root,
				mode   => 0644,
				source => "puppet:///modules/apacheexample/httpd.conf",
                                notify => Service['httpd'],
                                require => Package['httpd'],
			}
		}
	}
	file { "index.html":
		path   => "/var/www/html/index.html",
                owner  => root,
                group  => root,
                mode   => 0644,
		content => "<h1>Hello, world!</h1>",
		require => Package['httpd'],
	}
	file { "404.html":
                path   => "/var/www/html/404.html",
                owner  => root,
                group  => root,
                mode   => 0644,
                content => "<h1>404 Nothing to see here!</h1>",
                require => Package['httpd'],
        }
        file { ".htaccess":
                path   => "/var/www/html/.htaccess",
                owner  => root,
                group  => root,
                mode   => 0644,
                source => "puppet:///modules/apacheexample/.htaccess",
                require => Package['httpd'],
        }

}
