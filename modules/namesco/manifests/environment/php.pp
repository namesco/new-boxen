class namesco::environment::php {
	# Install PHP, then mod_fcgid, then configure Apache with the installed PHP
	# mod_fcgid
	include php

	$php_version = '5.6.26'

	# Install a php version and set as the global default php
	class { 'php::global':
	  version => $php_version
	}

	# Install PHP extensions
	php::extension::mcrypt { "mcrypt for {$php_version}":
		php => $php_version,
	}
	php::extension::memcache { "memcache for {$php_version}":
		php => $php_version,
	}
	php::extension::memcached { "memcached for {$php_version}":
		php => $php_version,
	}
	php::extension::xdebug { "xdebug for {$php_version}":
		php => $php_version,
		version => '2.4.1',
	}
	php::extension::runkit { "runkit for {$php_version}":
		php => $php_version,
	}
	php::extension::uopz { "uopz for {$php_version}":
		php => $php_version,
	}
	php::extension::xhprof { "xhprof for {$php_version}":
		php => $php_version,
	}
	php::extension::imap { "imap for {$php_version}":
		php => $php_version,
	}
	php::extension::pspell { "pspell for {$php_version}":
		php => $php_version,
	}
	php::extension::redis { "redis for {$php_version}":
		php => $php_version,
		version => '2.2.8'
	}
	php::extension::mongodb { "mongodb for {$php_version}":
		php => $php_version,
	}

	# Install Composer globally on your PATH
	include php::composer

	# Add vendor/bin to the PATH so that utilities installed by composer can
	# be found easily.
	file { "/etc/paths.d/composer-binaries":
			ensure => present,
			content => "vendor/bin\n"
	}

	# Also install PHP 5.3, because sometimes it is needed to run composer for
	# apps that run under 5.3 in production.
	$php53_version = '5.3.29'
	php::version { $php53_version: }

	$opensslcafile = "openssl.cafile = ${homebrew::config::installdir}/etc/openssl/cert.pem"

	# Install our custom php.ini so that we can set the cafile location and
	# ensure composer works with the Dada Root certificate authority.
	file { "${::boxen_home}/config/php/${php_version}/conf.d/namesco.ini":
        content => $opensslcafile,
        require => Php::Version[$php_version],
    }

	file { "${::boxen_home}/config/php/${php53_version}/conf.d/namesco.ini":
        content => $opensslcafile,
        require => Php::Version[$php53_version],
    }

	if (hiera('namesco::environment::php7')) {
		$php7_version = '7.0.11'
		php::extension::mcrypt { "mcrypt for {$php7_version}":
			php => $php7_version,
		}
		# Commented out because they do not have releases yet that are compatible with PHP 7
		#php::extension::memcache { "memcache for {$php7_version}":
		#	php => $php7_version,
		#}
		#php::extension::memcached { "memcached for {$php7_version}":
		#	php => $php7_version,
		#}
		php::extension::xdebug { "xdebug for {$php7_version}":
			php => $php7_version,
			version => '2.4.1',
		}
		#php::extension::runkit { "runkit for {$php7_version}":
		#	php => $php7_version,
		#}
		#php::extension::uopz { "uopz for {$php7_version}":
		#	php => $php7_version,
		#}
		#php::extension::xhprof { "xhprof for {$php7_version}":
		#	php => $php7_version,
		#}
		php::extension::imap { "imap for {$php7_version}":
			php => $php7_version,
		}
		php::extension::pspell { "pspell for {$php7_version}":
			php => $php7_version,
		}
		php::extension::redis { "redis for {$php7_version}":
			php => $php7_version,
			version => '3.0.0'
		}
		php::extension::mongodb { "mongodb for {$php7_version}":
			php => $php7_version,
		}
		file { "${::boxen_home}/config/php/${php7_version}/conf.d/namesco.ini":
	        content => $opensslcafile,
	        require => Php::Version[$php7_version],
	    }
	}

	if (hiera('namesco::environment::php71')) {
		$php71_version = '7.1.0RC3'
		php::extension::mcrypt { "mcrypt for {$php71_version}":
			php => $php71_version,
		}
		# Commented out because they do not have releases yet that are compatible with PHP 7
		#php::extension::memcache { "memcache for {$php71_version}":
		#	php => $php71_version,
		#}
		#php::extension::memcached { "memcached for {$php71_version}":
		#	php => $php71_version,
		#}
		#php::extension::xdebug { "xdebug for {$php71_version}":
		#	php => $php71_version,
		#	version => '2.4.1',
		#}
		#php::extension::runkit { "runkit for {$php71_version}":
		#	php => $php71_version,
		#}
		#php::extension::uopz { "uopz for {$php71_version}":
		#	php => $php71_version,
		#}
		#php::extension::xhprof { "xhprof for {$php71_version}":
		#	php => $php71_version,
		#}
		#php::extension::imap { "imap for {$php71_version}":
		#	php => $php71_version,
		#}
		php::extension::pspell { "pspell for {$php71_version}":
			php => $php71_version,
		}
		php::extension::redis { "redis for {$php71_version}":
			php => $php71_version,
			version => '3.0.0'
		}
		php::extension::mongodb { "mongodb for {$php71_version}":
			php => $php71_version,
		}
		file { "${::boxen_home}/config/php/${php71_version}/conf.d/namesco.ini":
	        content => $opensslcafile,
	        require => Php::Version[$php71_version],
	    }
	}
}
