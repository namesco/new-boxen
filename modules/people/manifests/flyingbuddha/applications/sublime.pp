class people::flyingbuddha::applications::sublime
{
    $home = "/Users/${::boxen_user}"
    $userPackages = "${home}/Library/Application Support/Sublime Text 3/Packages/User"

    include sublime_text_3
    include sublime_text_3::package_control

    sublime_text_3::package { 'ColorPicker':
        source => 'weslly/ColorPicker'
    }

    sublime_text_3::package { 'DocBlockr':
        source => 'spadgos/sublime-jsdocs'
    }

    sublime_text_3::package { 'FileDiffs':
        source => 'colinta/SublimeFileDiffs'
    }

    sublime_text_3::package { 'Gist':
        source => 'condemil/Gist'
    }

    sublime_text_3::package { 'GotoDocumentation':
        source => 'kemayo/sublime-text-2-goto-documentation'
    }

    sublime_text_3::package { 'Jasmine JS':
        source => 'NicoSantangelo/sublime-jasmine'
    }

    sublime_text_3::package { 'Phpcs':
        source => 'benmatselby/sublime-phpcs'
    }

    sublime_text_3::package { 'Puppet':
        source => 'russCloak/SublimePuppet'
    }

    sublime_text_3::package { 'Sass':
        source => 'nathos/sass-textmate-bundle'
    }

    sublime_text_3::package { 'SublimeCodeIntel':
        source => 'SublimeCodeIntel/SublimeCodeIntel'
    }

    sublime_text_3::package { 'Theme - Soda':
        source => 'buymeasoda/soda-theme'
    }

    sublime_text_3::package { 'TrailingSpaces':
        source => 'SublimeText/TrailingSpaces'
    }

    sublime_text_3::package { 'Xdebug Client':
        source => 'martomo/SublimeTextXdebug'
    }

    repository { 'checkout sublime-user-packages':
        source => 'git@bitbucket.org:flyingbuddha/sublime-user-packages.git',
        path => "${home}/sublime-user-packages",
    }

    exec { 'copy sublime user packages into place':
        command => "cp -R ${home}/sublime-user-packages/* '${userPackages}/'",
        creates => "${home}/.puppet-receipts/sublime-user-packages-installed",
        require => Repository['checkout sublime-user-packages'],
    }

    file { 'create receipt for package installation':
        path => "${home}/.puppet-receipts/sublime-user-packages-installed",
        content => generate('/bin/date', '+%Y%d%m_%H:%M:%S'),
        require => Exec['copy sublime user packages into place'],
    }
}
