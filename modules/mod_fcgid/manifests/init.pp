class mod_fcgid {
	include homebrew

	# As of macOS Sierra, the Apache Portable Runtime is no longer included with
	# CommandLineTools, so we should install it via homebrew. Should work find
	# on earlier versions too.
	package { ['apr', 'apr-util']:
		ensure => present
	}

	# For reasons unknown, apr-1-config --cc returns a path that doesn't exist:
    # /Applications/Xcode.app/Contents/Developer/Toolchains/OSX10.10.xctoolchain/usr/bin/cc
	# instead of
	# /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc
	# (This affects 10.8+, but the first path changes to include the version. So
	# we need to make sure that this exists first.
	# Use the exec type for this rather than file because then we can test
	# if mod_fcgid is installed before creating all these directories.
	exec { 'Create directories needed for compilation':
		command => "mkdir -p /Applications/Xcode.app/Contents/Developer/Toolchains/OSX${::macosx_productversion_major}.xctoolchain/usr/local/share /Applications/Xcode.app/Contents/Developer/Toolchains/OSX${::macosx_productversion_major}.xctoolchain/usr/bin /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${::macosx_productversion_major}.Internal.sdk/usr/include",
		user => 'root',
		unless => 'brew ls --versions mod_fcgid',
	}

	# Create symlinks to make the Apache Portable Runtime available where apxs
	# expects it to be
	# Again, using exec for these so we can test if mod_fcgid is installed, and
	# only do it if it is.
	exec { "ln -s ${homebrew::config::installdir}/Cellar/apr/1.5.2_3/libexec apr-1":
		cwd => "/Applications/Xcode.app/Contents/Developer/Toolchains/OSX${::macosx_productversion_major}.xctoolchain/usr/local/share/",
		user => 'root',
		unless => 'brew ls --versions mod_fcgid',
		require => Exec['Create directories needed for compilation']
	}

	exec { 'ln -s /usr/include/apr-1':
		cwd => "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${::macosx_productversion_major}.Internal.sdk/usr/include/",
		user => 'root',
		unless => 'brew ls --versions mod_fcgid',
		require => Exec['Create directories needed for compilation'],
	}

	# Make cc available where apxs reports it is.
	exec { 'ln -s /usr/bin/cc':
		cwd => "/Applications/Xcode.app/Contents/Developer/Toolchains/OSX${::macosx_productversion_major}.xctoolchain/usr/bin",
		user => 'root',
		unless => 'brew ls --versions mod_fcgid',
		require => Exec['Create directories needed for compilation'],
	}

	package { 'homebrew/apache/mod_fcgid':
		ensure => present,
		require => [
			Exec["ln -s ${homebrew::config::installdir}/Cellar/apr/1.5.2_3/libexec apr-1"],
			Exec['ln -s /usr/include/apr-1'],
			Exec['ln -s /usr/bin/cc'],
			Package['apr'],
		]
	}

	# Delete the Xcode.app directory if it is a "fake" we created just to get this installed
	exec { 'rm -Rf /Applications/Xcode.app':
		onlyif => '/bin/test ! -d /Applications/Xcode.app/Contents/Applications',
		require => Package['homebrew/apache/mod_fcgid'],
		user => 'root',
	}

}