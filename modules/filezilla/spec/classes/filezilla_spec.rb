require 'spec_helper'

describe 'filezilla' do

  version = '3.7.3'

  it { should contain_class('filezilla') }
  it { should contain_package("FileZilla-#{version}").with_provider('compressed_app') }
  it { should contain_package("FileZilla-#{version}").with_source("http://heanet.dl.sourceforge.net/project/filezilla/FileZilla_Client/#{version}/FileZilla_#{version}_i686-apple-darwin9.app.tar.bz2") }

end
