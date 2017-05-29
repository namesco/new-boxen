require 'spec_helper'

describe 'codekit' do
  it do
    should contain_package('CodeKit').with({
      :source   => 'http://incident57.com/codekit/files/codekit-18027.zip',
      :provider => 'compressed_app'
    })
  end
end
