# Public: Install KeePassX.app into /Applications.
#
# Examples
#
#   include keepassx
class keepassx {
  package { 'KeePassX':
    provider => 'appdmg',
    source   => 'http://downloads.sourceforge.net/keepassx/KeePassX-0.4.3.dmg'
  }
}
