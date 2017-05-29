class people::mikes1471 {

	$home_dir = "/Users/${::boxen_user}"

	include brewcask

	include projects::release
	include projects::website2

	package { [
		'firefox',
		'cornerstone',
		'microsoft-office',
		'codekit',
		'slack',
		'opera',
	]:
		provider => 'brewcask',
	}
}
