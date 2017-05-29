class people::pdunsford {

	$home_dir = "/Users/${::boxen_user}"

	include brewcask

	include projects::website1
	include projects::website2
	include projects::controlpanel3
	include projects::controlpanel4
	include projects::cronjobs
	include projects::kb
	include projects::ppc
	include projects::restapi
	include projects::sharedlibraries

	package { [
		'adobe-photoshop-cc',
		'google-chrome',
		'firefox',
		'cornerstone',
		'codekit',
		'sourcetree',
		'slack'
	]:
		provider => 'brewcask',
	}

	include sublime_text::v2

	# Checkout my personal config from Bitbucket
        #repository {
        #  "${home_dir}/dotfiles":
        #        source   => 'https://bwilliams@stash.server.dev/scm/~bwilliams/dotfiles.git',
        #        provider => 'git'
        #}

	#file { "${home_dir}/.bash_profile":
	#	ensure => link,
	#	target => "${home_dir}/dotfiles/bash_profile",
	#}

	#file { "${home_dir}/.ssh":
	#	ensure => directory
	#}

	#file { "${home_dir}/.ssh/config":
        #        ensure => link,
        #        target => "${home_dir}/dotfiles/sshconfig",
	#	require => File["${home_dir}/.ssh"],
        #}

}
