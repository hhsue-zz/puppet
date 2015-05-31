class users {

        user { 'john':
                ensure => 'absent',
                groups => ['root'],
                home => '/home/john',
                managehome => true,
                password => '$1$yk3gCUrE$8YuKoVri7zDsKQXM3nwe41',
                shell => '/bin/bash',
        }
        user { 'hhsue':
                ensure => 'present',
                home             => '/home/hhsue',
                groups           => 'root',
                password         => '$1$yk3gCUrE$8YuKoVri7zDsKQXM3nwe41',
                password_max_age => '-1',
                password_min_age => '-1',
                shell            => '/bin/bash',
        }
        user { 'postgres':
                ensure => 'present',
                home             => '/home/postgres',
                managehome       => true,
                groups           => 'root',
                password         => '$1$yk3gCUrE$8YuKoVri7zDsKQXM3nwe41',
                password_max_age => '-1',
                password_min_age => '-1',
                shell            => '/bin/bash',
        }
	file { '/home/hhsue':
	    ensure => directory,
	    owner => 'hhsue',
	    group => 'hhsue',
	    mode => 755,
	    source => 'puppet:///modules/users/hhsue',
	    recurse => remote,
	    require => User['hhsue'],
	}
}
