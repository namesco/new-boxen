require 'spec_helper'

describe 'php_require', :type => :puppet_function do
  before :all do
    Puppet::Parser::Functions.autoloader.loadall
  end

  it "should exist" do
    Puppet::Parser::Functions.function("php_require").should == "function_php_require"
  end

  it do
    should run.with_params('5.6.15')
  end
end
