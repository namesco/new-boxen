# Public: Installs TotalFinder in /Applications
#
# Examples:
#
#   include totalfinder
class totalfinder {
  package { 'TotalFinder':
    ensure   => installed,
    source   => 'http://downloads.binaryage.com/TotalFinder-1.4.18.dmg',
    provider => 'appdmg',
  }
}
