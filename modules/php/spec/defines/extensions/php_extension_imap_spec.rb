require 'spec_helper'

describe "php::extension::imap" do
  let(:facts) { default_test_facts }
  let(:title) { "imap for 5.4.17" }
  let(:params) do
    {
      :php     => "5.4.17",
    }
  end

  it do
    should contain_class("php::config")
    should contain_class("imap")
    should contain_php__version("5.4.17")

    should contain_php_extension("imap for 5.4.17").with({
      :provider         => "php_source",
      :extension        => "imap",
      :homebrew_path    => "/test/boxen/homebrew",
      :phpenv_root      => "/test/boxen/phpenv",
      :php_version      => "5.4.17",
      :configure_params => "--with-imap=/test/boxen/homebrew/opt/imap --with-imap-ssl --with-kerberos",
    })

    should contain_file("/test/boxen/config/php/5.4.17/conf.d/imap.ini").with({
      :content => File.read("spec/fixtures/imap.ini"),
      :require => "Php_extension[imap for 5.4.17]"
    })
  end
end
