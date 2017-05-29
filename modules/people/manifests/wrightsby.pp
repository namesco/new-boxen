class people::wrightsby {
	include dropbox
	include onepassword
	include textmate
	include chrome
	include firefox
	include transmit

	# install apps through brew-cask
	package {[
		'codekit',
	    'cornerstone',
	] : provider => 'brewcask', install_options => ['--appdir=/Applications'] }


}
