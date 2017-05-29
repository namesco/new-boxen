require 'formula'

class Rabbitmq < Formula
  homepage 'https://www.rabbitmq.com'
  url 'https://www.rabbitmq.com/releases/rabbitmq-server/v3.5.1/rabbitmq-server-mac-standalone-3.5.1.tar.gz'
  sha256 '6c5986d86d4ff93c945f5e70c995d033558dca94e5eabd4fb4833ea813489177'
  version '3.5.1-boxen1'

  bottle do
    sha256 "91c6f8814eced0b996580390325f55efdf83b40b8d5ac6898f31ccc7f26e9ef8" => :yosemite
    sha256 "dcbe969881c390e288388a8a121878fb384a8cbf8d89f420862d6e9ef4f3a2c8" => :mavericks
    sha256 "eb07306c5f3fb1932e90bcb98a8aad149a73a2a766b179ebfd5907f3cdd1225b" => :mountain_lion
  end

  depends_on 'simplejson' => :python if MacOS.version <= :leopard

  def install
    # Install the base files
    prefix.install Dir['*']

    # Setup the lib files
    (var+'lib/rabbitmq').mkpath
    (var+'log/rabbitmq').mkpath

    # Correct SYS_PREFIX for things like rabbitmq-plugins
    inreplace sbin/'rabbitmq-defaults' do |s|
      s.gsub! 'SYS_PREFIX=${RABBITMQ_HOME}', "SYS_PREFIX=#{HOMEBREW_PREFIX}"
      s.gsub! 'CLEAN_BOOT_FILE="${SYS_PREFIX}', "CLEAN_BOOT_FILE=\"#{prefix}"
      s.gsub! 'SASL_BOOT_FILE="${SYS_PREFIX}', "SASL_BOOT_FILE=\"#{prefix}"
    end

    # Set RABBITMQ_HOME in rabbitmq-env
    inreplace (sbin + 'rabbitmq-env'), 'RABBITMQ_HOME="${SCRIPT_DIR}/.."', "RABBITMQ_HOME=#{prefix}"

    boxenless_version = version.to_s.gsub(/-boxen[0-9]+$/, '')

    # Extract rabbitmqadmin and install to sbin
    # use it to generate, then install the bash completion file
    system "/usr/bin/unzip", "-qq", "-j",
           "#{prefix}/plugins/rabbitmq_management-#{boxenless_version}.ez",
           "rabbitmq_management-#{boxenless_version}/priv/www/cli/rabbitmqadmin"

    sbin.install 'rabbitmqadmin'
    (sbin/'rabbitmqadmin').chmod 0755
    (bash_completion/'rabbitmqadmin.bash').write `#{sbin}/rabbitmqadmin --bash-completion`
  end

  def caveats; <<-EOS.undent
    Management Plugin enabled by default at http://localhost:15672
    EOS
  end
end