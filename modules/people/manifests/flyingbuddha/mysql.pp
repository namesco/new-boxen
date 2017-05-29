class people::flyingbuddha::mysql {

	$home = "/Users/${::boxen_user}"

	exec { "create root user with password password":
		command => "echo \"SET PASSWORD FOR 'root'@'localhost' = PASSWORD('password');\" | mysql -u root",
		creates => "${home}/.puppet-receipts/mysql-root-password-changed"
	}

	file { 'create receipt of mysql password update':
    	path => "${home}/.puppet-receipts/mysql-root-password-changed",
    	content => generate('/bin/date', '+%Y%d%m_%H:%M:%S'),
    	require => Exec['create root user with password password'],
    }
}