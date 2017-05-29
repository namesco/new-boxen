class people::far_blue::sourcetree {

	package { 'SourceTree':
		ensure   => 'installed',
		provider => 'appdmg',
		source   => "http://downloads.atlassian.com/software/sourcetree/SourceTree_2.0.5.2.dmg",
	}
}
