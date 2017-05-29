require 'spec_helper'

describe "php::extension::uopz" do
  let(:facts) { default_test_facts }
  let(:title) { "uopz for 5.4.17" }
  let(:params) do
    {
      :php     => "5.4.17",
      :version => "2.0.6"
    }
  end

  it do
    should contain_class("php::config")
    should contain_php__version("5.4.17")

    should contain_repository("/test/boxen/data/php/cache/extensions/uopz").with({
      :source => "krakjoe/uopz"
    })

    should contain_php_extension("uopz for 5.4.17").with({
      :provider         => "git",
      :extension        => "uopz",
      :version          => "v2.0.6",
      :homebrew_path    => "/test/boxen/homebrew",
      :phpenv_root      => "/test/boxen/phpenv",
      :php_version      => "5.4.17",
      :cache_dir        => "/test/boxen/data/php/cache/extensions",
      :require          => "Repository[/test/boxen/data/php/cache/extensions/uopz]",
      :configure_params => '',
    })

    should contain_file("/test/boxen/config/php/5.4.17/conf.d/uopz.ini").with({
      :content => File.read("spec/fixtures/uopz.ini"),
      :require => "Php_extension[uopz for 5.4.17]"
    })
  end
end
