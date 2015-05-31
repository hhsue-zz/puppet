# == Class: django
#
# Full description of class django here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'django':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class django {

}


class django::install {
    package { [ "python", "python-dev", "python-virtualenv", "python-pip",
                "python-psycopg2", "python-imaging"]:
        ensure => present,
    }
}


 define django::virtualenv( $path ){
     exec { "create-ve-$path":
         command => "/usr/bin/virtualenv -q $name",
         cwd => $path,
         creates => "$path/$name",
         require => [Class["django::install"]],
     }
 }

class django::environment {
    django::virtualenv{ 've':
        path => '/usr/local/app',
    }
}

