# Public: Install Thunderbird to /Applications
#
# Examples
#
#  include thunderbird
#  class { 'thunderbird':
#    version => '24.3.0',
#    locale  => 'fr',
#  }
#
class thunderbird($version='24.3.0', $locale = 'en-US') {

  package { "Thunderbird-${version}":
    provider => 'appdmg',
    source   => "http://download-origin.cdn.mozilla.net/pub/mozilla.org/thunderbird/releases/${version}/mac/${locale}/Thunderbird%20${version}.dmg",
  }

}
