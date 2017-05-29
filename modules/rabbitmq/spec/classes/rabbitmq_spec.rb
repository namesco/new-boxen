require 'spec_helper'

describe 'rabbitmq' do
  let(:facts) do
    {
      :boxen_home => '/test/boxen'
    }
  end

  it do
    
    should include_class('homebrew')

    should contain_homebrew__formula('rabbitmq').
      with_before('Package[boxen/brews/rabbitmq]')

    should contain_package('boxen/brews/rabbitmq').with({
      :ensure => '3.5.1-boxen1'
    })

  end
end
