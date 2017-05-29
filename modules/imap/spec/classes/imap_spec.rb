require 'spec_helper'

describe 'imap' do
  let(:facts) do
    {
      :boxen_home => '/test/boxen'
    }
  end

  it do
    
  	should include_class('homebrew')

  	#should contain_homebrew__formula('imap-uw').
  	#  with_before('Package[boxen/brews/imap-uw]')

  	#should contain_package('boxen/brews/imap-uw').with({
    #  :ensure => 'imap-2007f-boxen1'
  	#})

  end
end
