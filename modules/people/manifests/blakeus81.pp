class people::blakeus81 {

	$home_dir = "/Users/${::boxen_user}"

	include brewcask

	include projects::release
	include projects::website2
	include projects::controlpanel3
	include projects::controlpanel4
	include projects::cronjobs
	include projects::kb
	include projects::namesxmas
	include projects::r365xmas
	include projects::phxmas

	package { [
		'adobe-photoshop-cc',
		'adobe-illustrator-cc',
		'google-chrome',
		'firefox',
		'cornerstone',
		'microsoft-office',
		'codekit',
		'spotify',
		'slack'
	]:
		provider => 'brewcask',
	}

	include sublime_text::v2

	# Checkout my personal config from Bitbucket
        repository {
          "${home_dir}/dotfiles":
                source   => 'https://bwilliams@stash.server.dev/scm/~bwilliams/dotfiles.git',
                provider => 'git'
        }

	file { "${home_dir}/.bash_profile":
		ensure => link,
		target => "${home_dir}/dotfiles/bash_profile",
	}

	file { "${home_dir}/.ssh":
		ensure => directory
	}

	file { "${home_dir}/.ssh/config":
                ensure => link,
                target => "${home_dir}/dotfiles/sshconfig",
		require => File["${home_dir}/.ssh"],
        }

}
