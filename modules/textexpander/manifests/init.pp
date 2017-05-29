class textexpander {
  package { 'textexpander':
    provider   => 'compressed_app',
    source => 'http://dl.smilesoftware.com/com.smileonmymac.textexpander/TextExpander.zip'
  }
}
