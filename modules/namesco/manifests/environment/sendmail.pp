class namesco::environment::sendmail
{
    $home = "/Users/${::boxen_user}"
    $email = hiera('namesco::user::email')

    exec { 'move sendmail out the way for namesco':
    	command => 'mv /usr/sbin/sendmail /usr/sbin/sendmail_real',
    	creates => '/usr/sbin/sendmail_real',
    	user => 'root',
	}

	file { 'create fake sendmail for namesco':
		path => '/usr/sbin/sendmail',
		content => template('namesco/sendmail.sh.erb'),
		mode => '0755',
		ensure => present,
		owner => 'root',
		require => Exec['move sendmail out the way for namesco'],
	}

	# El Cap onwards doesn't include formail, so we need to install it from
	# homebrew.
	package { 'procmail':
		ensure => present,
	}
}