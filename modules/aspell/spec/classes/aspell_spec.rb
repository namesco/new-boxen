require 'spec_helper'

describe 'aspell' do
  let(:facts) do
    {
      :boxen_home => '/test/boxen'
    }
  end

  it do
    
  	should include_class('homebrew')

  	should contain_homebrew__formula('aspell').
  	  with_before('Package[boxen/brews/aspell]')

  	should contain_package('boxen/brews/aspell').with({
      :ensure => '0.60.6.1-boxen1'
  	})

  end
end
