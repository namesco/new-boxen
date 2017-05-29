require 'spec_helper'

describe 'thunderbird' do

  version = '24.3.0'

  it { should contain_class('thunderbird') }
  it { should contain_package("Thunderbird-#{version}").with_provider('appdmg') }

  context "default language" do
    it { should contain_package("Thunderbird-#{version}").with_source("http://download-origin.cdn.mozilla.net/pub/mozilla.org/thunderbird/releases/#{version}/mac/en-US/Thunderbird%20#{version}.dmg") }
  end

  context "other language" do
    let(:params) do
      { :locale => 'fr' }
    end

    it { should contain_package("Thunderbird-#{version}").with_source("http://download-origin.cdn.mozilla.net/pub/mozilla.org/thunderbird/releases/#{version}/mac/fr/Thunderbird%20#{version}.dmg") }
  end

end
