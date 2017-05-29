class people::flyingbuddha::applications::sendmail
{
    $home = "/Users/${::boxen_user}"

    exec { 'move sendmail out the way':
    	command => 'mv /usr/sbin/sendmail /usr/sbin/sendmail_real',
    	creates => '/usr/sbin/sendmail_real',
    	user => 'root',
	}

	file { 'create fake sendmail':
		path => '/usr/sbin/sendmail',
		content => template('people/flyingbuddha/applications/sendmail.sh'),
		mode => '0755',
		ensure => present,
		owner => 'root',
		require => Exec['move sendmail out the way'],
	}
}