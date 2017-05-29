# Install Reggy.
class reggy (
  $version = 'v1.3',
) {
  package { 'Reggy':
    provider => 'compressed_app',
    source   => "http://github.com/downloads/samsouder/reggy/Reggy_${version}.tbz",
  }
}
