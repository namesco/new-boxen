require 'spec_helper'

describe "php::extension::mailparse" do
  let(:facts) { default_test_facts }
  let(:title) { "mailparse for 5.4.17" }
  let(:params) do
    {
      :php     => "5.4.17",
      :version => "2.1.6"
    }
  end

  it do
    should contain_class("boxen::config")
    should contain_class("php::config")
    should contain_php__version("5.4.17")

    should contain_php_extension("mailparse for 5.4.17").with({
      :extension        => "mailparse",
      :version          => "2.1.6",
      :package_name     => "mailparse-2.1.6",
      :package_url      => "http://pecl.php.net/get/mailparse-2.1.6.tgz",
      :homebrew_path    => "/test/boxen/homebrew",
      :phpenv_root      => "/test/boxen/phpenv",
      :php_version      => "5.4.17",
      :cache_dir        => "/test/boxen/data/php/cache/extensions",
      :configure_params => '',
    })

    should contain_file("/test/boxen/config/php/5.4.17/conf.d/mailparse.ini").with({
      :content => File.read("spec/fixtures/mailparse.ini"),
      :require => "Php_extension[mailparse for 5.4.17]"
    })
  end
end
