class people::flyingbuddha::projects
{
    $projects = hiera('projects')

    # uses puppet future parser, 3.8+
    # script/boxen --future-parser --noop

    exec { 'ensure composer is up-to-date':
        command => "${::boxen_home}/phpenv/bin/composer selfupdate",
    }

    # @todo need to manage dependencies in here better, execution order.

    # container dir, for projects that store a mixture of linked nested projects
    each($projects['containerDirectories']) |$container| {
        exec { "create container directory: ${container}":
            command => "mkdir -p ${container}",
            creates => $container,
            user => 'mholloway',
            group => 'staff',
        }
    }

    each($projects['subversion']) |$svn| {
        exec { "checking out repo to ${svn['dest']}":
            command => "svn checkout ${svn['repo']} ${svn['dest']}",
            creates => $svn['dest'],
            user => 'mholloway',
            group => 'staff',
        }

        # link up project config files from /Volumes/Sites/namesco-configs
        if $svn['configs'] != undef {
            each ($svn['configs']) |$config| {

                $configPath = dirname($config['dest'])

                file { "${svn['repo']}: adding local config ${config['dest']}":
                    path => $config['dest'],
                    source => $config['src'],
                    require => Repository['checkout namesco-configs'],
                }

                # drop a version file in each of the projects
                if $config['version'] != undef and $config['version'] == true {
                    file { "${svn['repo']}: adding version file ${configPath}/version":
                        path => "${configPath}/version",
                        content => generate('/bin/date', '+%Y%d%m_%H:%M:%S'),
                    }
                }
            }
        }

        # run composer in each of projects root
        exec { "${svn['dest']}: composer install":
            command => "${::boxen_home}/phpenv/bin/composer install",
            cwd => $svn['dest'],
            onlyif => "test -f ${svn['dest']}/composer.json",
            require => Exec["checking out repo to ${svn['dest']}"],
        }
    }

    each($projects['links']) |$link| {
        exec { "linking project: ${link}":
            command => "ln -s ${link['src']} ${link['dest']}",
            creates => $link['dest'],
        }
    }

    # third-party libs
    each($projects['git']) |$git| {
        repository { $git['dest']:
            source => $git['repo'],
        }
    }

    # data dir, for storing site output
    each($projects['data']) |$data| {
        exec { "creating data directory: ${data}":
            command => "mkdir -m 0700 -p ${data}",
            creates => $data,
        }
    }
}
