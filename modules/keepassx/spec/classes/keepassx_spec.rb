require 'spec_helper'

describe 'keepassx' do
  it do
    should contain_package('KeePassX').with({
      :provider => 'appdmg',
      :source   => 'http://downloads.sourceforge.net/keepassx/KeePassX-0.4.3.dmg',
    })
  end
end
