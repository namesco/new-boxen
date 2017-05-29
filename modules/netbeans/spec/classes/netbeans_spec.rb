require 'spec_helper'

describe 'netbeans' do
  it do
    should contain_class('netbeans')
    should contain_package('netbeans').with({
      :provider => 'pkgdmg',
      :source   => 'http://download.netbeans.org/netbeans/8.0.1/final/bundles/netbeans-8.0.1-macosx.dmg'
    })
  end
end
