# Public: Install FileZilla to /Applications
#
# Examples
#
#  include filezilla
#  class { 'filezilla':
#    version => '3.7.4.1'
#  }
#
class filezilla($version='3.7.4.1') {

  package { "FileZilla-${version}":
    provider => 'compressed_app',
    source   => "http://heanet.dl.sourceforge.net/project/filezilla/FileZilla_Client/${version}/FileZilla_${version}_i686-apple-darwin9.app.tar.bz2",
  }

}
