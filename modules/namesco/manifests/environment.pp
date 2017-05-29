class namesco::environment {

	include namesco::environment::python
	if (hiera('namesco::environment::apache')) {
		include namesco::environment::apache
	}

	if (hiera('namesco::environment::php')) {
		include namesco::environment::php
	}

	if (hiera('namesco::environment::sendmail')) {
		include namesco::environment::sendmail
	}

	if (hiera('namesco::environment::docker')) {
		include namesco::environment::docker
	}

	if ("$homebrew::config::installdir" != '/usr/local') {
		file { "Ensure /usr/local/bin owned":
			path => "/usr/local/bin",
			ensure => directory,
			owner => $::boxen_user,
		}
	}

	file { "/Users/${::boxen_user}/.bowerrc":
		content => template('namesco/bowerrc.erb'),
	}

	# Add the Dada Root certificate to the keychain so we can access sites
	# signed by it.
	exec { "security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ${::boxen_repodir}/modules/namesco/files/environment/dadaroot.pem":
		user => 'root',
		unless => 'security dump-trust-settings -d | grep Dada',
		notify => Exec["security find-certificate -a -p /Library/Keychains/System.keychain > ${homebrew::config::installdir}/etc/openssl/cert.pem"],
	}

	# Add the Namesco Root certificate to the keychain so we can access sites
	# signed by it.
	exec { "security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ${::boxen_repodir}/modules/namesco/files/environment/namescoroot.pem":
		user => 'root',
		unless => 'security dump-trust-settings -d | grep server.dev',
		notify => Exec["security find-certificate -a -p /Library/Keychains/System.keychain > ${homebrew::config::installdir}/etc/openssl/cert.pem"],
	}

	# Add the F5 self signed certificate to the keychain so we can talk to the F5s
	exec { "security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ${::boxen_repodir}/modules/namesco/files/environment/f5-localhost.localdomain.pem":
		user => 'root',
		unless => 'security dump-trust-settings -d | grep localhost.localdomain',
		notify => Exec["security find-certificate -a -p /Library/Keychains/System.keychain > ${homebrew::config::installdir}/etc/openssl/cert.pem"],
	}

	# Update the certificates used by OpenSSL so that the Dada Root certificate
	# is available to that too.
	exec { "security find-certificate -a -p /Library/Keychains/System.keychain > ${homebrew::config::installdir}/etc/openssl/cert.pem":
		refreshonly => 'true',
		notify => Exec["security find-certificate -a -p /System/Library/Keychains/SystemRootCertificates.keychain >> ${homebrew::config::installdir}/etc/openssl/cert.pem"],
	}

	exec { "security find-certificate -a -p /System/Library/Keychains/SystemRootCertificates.keychain >> ${homebrew::config::installdir}/etc/openssl/cert.pem":
		refreshonly => true,
	}

	# Install Apps
	# (ok, this doesn't really do that, it does loads of stuff, it needs
	# refactoring out, see flyingbuddha's personal manifests for a good example)
	include namesco::apps::mac
}
