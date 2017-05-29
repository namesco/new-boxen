require 'spec_helper'
describe 'reggy' do
  it do
    should contain_class('reggy')
    should contain_package('Reggy').with_provider('compressed_app')
    should contain_package('Reggy').with_source('http://github.com/downloads/samsouder/reggy/Reggy_v1.3.tbz')
  end
end
