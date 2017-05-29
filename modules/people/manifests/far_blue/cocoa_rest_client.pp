class people::far_blue::cocoa_rest_client {

	package { 'CocoaRestClient':
		ensure   => 'installed',
		provider => 'appdmg',
		source   => "https://github.com/mmattozzi/cocoa-rest-client/releases/download/1.3.9/CocoaRestClient-1.3.9.dmg",
	}
}
