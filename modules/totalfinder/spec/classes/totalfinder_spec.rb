require 'spec_helper'

describe 'totalfinder' do
  it do
    should contain_class(:totalfinder)
    should contain_package('TotalFinder').with({
      :source     => "http://downloads.binaryage.com/TotalFinder-1.4.18.dmg",
      :provider   => "appdmg"
    })
  end
end
