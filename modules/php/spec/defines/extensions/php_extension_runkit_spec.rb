require 'spec_helper'

describe "php::extension::runkit" do
  let(:facts) { default_test_facts }
  let(:title) { "runkit for 5.4.17" }
  let(:params) do
    {
      :php     => "5.4.17",
      :version => "1.0.3"
    }
  end

  it do
    should contain_class("php::config")
    should contain_php__version("5.4.17")

    should contain_repository("/test/boxen/data/php/cache/extensions/runkit").with({
      :source => "namesco/runkit"
    })

    should contain_php_extension("runkit for 5.4.17").with({
      :provider         => "git",
      :extension        => "runkit",
      :version          => "1.0.3",
      :homebrew_path    => "/test/boxen/homebrew",
      :phpenv_root      => "/test/boxen/phpenv",
      :php_version      => "5.4.17",
      :cache_dir        => "/test/boxen/data/php/cache/extensions",
      :require          => "Repository[/test/boxen/data/php/cache/extensions/runkit]",
    })

    should contain_file("/test/boxen/config/php/5.4.17/conf.d/runkit.ini").with({
      :content => File.read("spec/fixtures/runkit.ini"),
      :require => "Php_extension[runkit for 5.4.17]"
    })
  end
end
