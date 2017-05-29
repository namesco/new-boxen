class namesco::environment::python {
	include python

	$version = '2.7.10'

	# Install a python version and set as the global default python
	class { 'python::global':
	  version => $version
	}

	python::package { "fabric for ${version}":
		package => 'fabric',
  		python  => $version,
	}

}
