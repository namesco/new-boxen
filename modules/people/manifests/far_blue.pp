class people::far_blue {

	include people::far_blue::sites
	include people::far_blue::unwanted
	include people::far_blue::profile
	include people::far_blue::solarized
	include people::far_blue::spideroak
	include people::far_blue::xcode_svn
	include people::far_blue::cocoa_rest_client
	include people::far_blue::cord
	include people::far_blue::sourcetree
	include people::far_blue::svn_settings
	include people::far_blue::mercurial
	include people::far_blue::docker_apps

	file { 'create receipts directory':
		path => "/Users/${::boxen_user}/.puppet-receipts",
		ensure => "directory",
	}

	#
	# Setup OSX
	#
	include osx::global::expand_save_dialog
	include osx::finder::unhide_library
	include osx::safari::enable_developer_mode
	include osx::mouse::swipe_between_pages
	class { 'osx::mouse::button_mode':
		mode => 2
	}
	osx::dock::hot_corner { 'Bottom Left':
		action => 'Start Screen Saver'
	}

	$home = "/Users/${::boxen_user}"

	#
	# install apps
	#
	include flux
	include reggy
	include onepassword
	include transmit

	#
	# Homebrew: Apps.....
	#

	#
	# Homebrew: Cask (GUI) Apps.....
	#
	package {[
		'macgdbp',
		'colloquy',
	]: provider => 'brewcask', install_options => ['--appdir=/Applications']}

	# Switch active xcode to xcode app (as opposed to cmdline toolset)
	exec { "select xcode app":
		command => 'xcode-select --switch /Applications/Xcode.app/Contents/Developer',
		onlyif => 'xcode-select --print-path | grep -v /Applications/Xcode.app/Contents/Developer',
		user => 'root',
		subscribe => Class['mod_fcgid'],
	}

}
