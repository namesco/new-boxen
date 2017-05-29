class people::far_blue::spideroak {

	package { 'SpiderOak':
		ensure   => 'installed',
		provider => 'appdmg',
		source   => "https://spideroak.com/getbuild?platform=mac",
	}
}
