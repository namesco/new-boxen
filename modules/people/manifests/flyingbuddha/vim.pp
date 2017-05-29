class people::flyingbuddha::vim
{
    $home = "/Users/${::boxen_user}"

    # setup vim
    file { 'setup vim preferences':
        path => "${home}/.vimrc",
        content => template("people/flyingbuddha/vim/.vimrc"),
    }

	# because puppet can't recursively create directories?!
	exec { 'create vim color dir':
		command => "mkdir -p ${home}/.vim/colors",
		creates => "${home}/.vim/colors",
	}

    file { 'add vim theme':
        path => "${home}/.vim/colors/solarized.vim",
        content => template("people/flyingbuddha/vim/solarized.vim"),
		require => Exec['create vim color dir'],
    }
}
