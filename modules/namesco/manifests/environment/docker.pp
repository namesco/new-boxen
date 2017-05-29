class namesco::environment::docker {

	package { [
		'docker-compose',
		'docker-machine',
	]:
		ensure => present,
	}

	# Set priority to 999 to ensure startup script is loaded last.
	file { "${::boxen_home}/env.d/999-docker.sh":
        source => 'puppet:///modules/namesco/environment/docker/env.sh',
    }

    ## Setup dev VM

    # Create docker machine
    exec { 'docker-machine create --driver virtualbox --engine-insecure-registry "docker.server.dev:5000" dev':
        require => [
            Package['docker-compose'],
            Package['docker-machine'],
        ],
    	unless => "docker-machine ls | grep dev",
    }

    # Create the bootsync and bootlocal files
    file { '/Users/Shared/bootsync':
    	source => 'puppet:///modules/namesco/environment/docker/bootsync',
    }
    file { '/Users/Shared/bootlocal':
    	source => 'puppet:///modules/namesco/environment/docker/bootlocal',
    }

    # Inject them into the dev VM
    exec { 'docker-machine ssh dev sudo cp /Users/Shared/bootsync /mnt/sda1/var/lib/boot2docker/bootsync.sh':
    	require => [
            Exec['docker-machine create --driver virtualbox --engine-insecure-registry "docker.server.dev:5000" dev'],
            File['/Users/Shared/bootsync'],
        ],
    	unless => 'docker-machine ssh dev \'ls -l /mnt/sda1/var/lib/boot2docker/\' | grep bootsync.sh',
    	before => Exec['docker-machine stop dev']
    }
    exec { 'docker-machine ssh dev sudo cp /Users/Shared/bootlocal /mnt/sda1/var/lib/boot2docker/bootlocal.sh':
    	require => [
            Exec['docker-machine create --driver virtualbox --engine-insecure-registry "docker.server.dev:5000" dev'],
            File['/Users/Shared/bootlocal'],
        ],
    	unless => 'docker-machine ssh dev \'ls -l /mnt/sda1/var/lib/boot2docker/\' | grep bootlocal.sh',
    	before => Exec['docker-machine stop dev']
    }
    exec { 'docker-machine ssh dev sudo chmod a+x /mnt/sda1/var/lib/boot2docker/bootsync.sh':
    	refreshonly => true,
    	subscribe => Exec['docker-machine ssh dev sudo cp /Users/Shared/bootsync /mnt/sda1/var/lib/boot2docker/bootsync.sh'],
    	before => Exec['docker-machine stop dev']
    }
    exec { 'docker-machine ssh dev sudo chmod a+x /mnt/sda1/var/lib/boot2docker/bootlocal.sh':
    	refreshonly => true,
    	subscribe => Exec['docker-machine ssh dev sudo cp /Users/Shared/bootlocal /mnt/sda1/var/lib/boot2docker/bootlocal.sh'],
    	before => Exec['docker-machine stop dev']
    }

    ## Reconfigure VM

    # Stop the VM while we fiddle with some settings
    exec { 'docker-machine stop dev':

    }

    # Assumption here is that you have projects::volumessites set to true.
    exec { 'VBoxManage sharedfolder add dev --name Sites --hostpath /Volumes/Sites --automount':
    	unless => 'VBoxManage showvminfo dev | grep "Name: \'Sites\', Host path:"',
    	require => Exec['docker-machine stop dev'],
    }
    exec { 'VBoxManage setextradata dev "VBoxInternal2/SharedFoldersEnableSymlinksCreate/Sites" "1"':
    	unless => 'VBoxManage getextradata dev "VBoxInternal2/SharedFoldersEnableSymlinksCreate/Sites" | grep 1',
    	require => Exec['docker-machine stop dev'],
    }

    $bridge = hiera('namesco::environment::docker::bridge')
    exec { "VBoxManage modifyvm dev --nic3 bridged --nictype3 82540EM --bridgeadapter3 \"${bridge}\" --nicpromisc3 deny --macaddress3 ${::generated_mac}":
    	unless => "VBoxManage showvminfo dev | grep \"NIC 3:           MAC: [0-9A-F]\\{12\\}, Attachment: Bridged Interface '${bridge}'\"",
    	require => Exec['docker-machine stop dev']
    }

    # Regnerate certs so they work with the (192.168.99.102) static IP
    exec { 'docker-machine regenerate-certs -f dev':
    	refreshonly => true,
    	subscribe => Exec['docker-machine create --driver virtualbox --engine-insecure-registry "docker.server.dev:5000" dev'],
    	require => Exec['docker-machine stop dev'],
    }

    ## VM is now ready-to-use 

    exec { 'docker-machine start dev':
    	refreshonly => true,
    	subscribe => Exec['docker-machine stop dev'],
    	require => [
    		Exec['VBoxManage sharedfolder add dev --name Sites --hostpath /Volumes/Sites --automount'],
    		Exec['VBoxManage setextradata dev "VBoxInternal2/SharedFoldersEnableSymlinksCreate/Sites" "1"'],
    		Exec['docker-machine regenerate-certs -f dev'],
    	]
    }
}