require 'spec_helper'

describe 'php_fpm_require', :type => :puppet_function do
  before :all do
    Puppet::Parser::Functions.autoloader.loadall
  end

  it "should exist" do
    Puppet::Parser::Functions.function("php_fpm_require").should == "function_php_fpm_require"
  end

  it do
    should run.with_params('5.6.15')
  end
end
