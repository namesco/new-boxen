class people::flyingbuddha::apache
{
	require namesco::environment::php
	include namesco::apps::mac

	file { 'create ssl dir':
		path => '/etc/apache2/ssl',
		owner => 'root',
		group => 'wheel',
		ensure => 'directory',
	}
	->
	recursive_directory { 'copy wireshark ssl keys to apache':
		source_dir => 'people/flyingbuddha/apache/ssl',
		dest_dir   => '/etc/apache2/ssl',
		file_mode  => '0644',
		dir_mode   => '0755',
		owner => 'root',
		group => 'wheel',
	}

	file { 'remove "other" apache configs':
		path => '/etc/apache2/other',
		ensure => 'directory',
		recurse => true,
		purge => true,
		owner => 'root',
		group => 'wheel',
	}

	create_resources(file, {
		'apache: enabling ssl' => {
			path => "/etc/apache2/other/001-ssl.conf",
	        content => template("people/flyingbuddha/apache/001-ssl.conf"),
		},
		'apache: enabling vhosts' => {
			path => "/etc/apache2/other/002-vhosts.conf",
	        content => template("people/flyingbuddha/apache/002-vhosts.conf"),
		},
		'apache: enabling default' => {
			path => "/etc/apache2/other/003-default.conf",
	        content => template("people/flyingbuddha/apache/003-default.conf"),
		},
		'apache: enabling apaxy' => {
			path => "/etc/apache2/other/004-apaxy-theme.conf",
	        content => template("people/flyingbuddha/apache/004-apaxy-theme.conf"),
		},
		'apache: enabling xhprof' => {
			path => "/etc/apache2/other/005-xhprof.conf",
	        content => template("people/flyingbuddha/apache/005-xhprof.conf"),
		},
		'apache: enabling php' => {
			path => "/etc/apache2/other/006-php5.conf",
	        content => template("people/flyingbuddha/apache/006-php5.conf"),
		},
		'apache: enabling hike-php' => {
			path => "/etc/apache2/other/007-hike-php.conf",
	        content => template("people/flyingbuddha/apache/007-hike-php.conf"),
		},
	}, {
		owner => root,
		group => wheel,
		require => File['remove "other" apache configs'],
	})
}