# Public: Install TextWrangler
#
# Usage:
#
#   include textwrangler
class textwrangler {
  package { 'TextWrangler':
    source   => 'https://s3.amazonaws.com/BBSW-download/TextWrangler_4.5.11.dmg',
    provider => 'appdmg'
  }
}
