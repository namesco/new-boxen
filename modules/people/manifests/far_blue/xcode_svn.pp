class people::far_blue::xcode_svn {

	file { 'Check Xcode exists':
		path => "/Applications/Xcode.app/Contents/Developer/usr/bin",
		ensure => present,
	}

	file { 'Upgrade Xcode SVN version':
		path => "/Applications/Xcode.app/Contents/Developer/usr/bin/svn",
		ensure => link,
		target => "/opt/boxen/homebrew/bin/svn",
		replace => true,
		require => File['Check Xcode exists'],
	}
}
