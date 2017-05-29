# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

# Shortcut for a module from GitHub's boxen organization
def github(name, *args)
  options ||= if args.last.is_a? Hash
    args.last
  else
    {}
  end

  if path = options.delete(:path)
    mod name, :path => path
  else
    version = args.first
    options[:repo] ||= "boxen/puppet-#{name}"
    mod name, version, :github_tarball => options[:repo]
  end
end

# Shortcut for a module under development
def dev(name, *args)
  mod "puppet-#{name}", :path => "#{ENV['HOME']}/src/boxen/puppet-#{name}"
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen", "3.12.0"

# Support for default hiera data in modules

github "module_data", "0.0.4", :repo => "ripienaar/puppet-module-data"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github "brewcask",    "0.0.7"
github "dnsmasq",     "2.0.2"
github "foreman",     "1.2.0"
github "gcc",         "3.0.2"
github "git",         "2.12.2"
github "go",          "2.1.0"
github "homebrew",    "2.1.0"
github "hub",         "1.4.4"
github "inifile",     "1.4.1", :repo => "puppetlabs/puppetlabs-inifile"
github "nginx",       "1.7.0"
github "nodejs",      "5.0.9"
github "openssl",     "1.0.0"
github "phantomjs",   "3.0.0"
github "pkgconfig",   "1.0.0"
github "repository",  "2.4.1"
github "ruby",        "8.5.4"
github "stdlib",      "4.7.0", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",        "1.0.0"
github "xquartz",     "1.2.1"

# Optional/custom modules. There are tons available at
# https://github.com/boxen.

github "adium",           "1.4.0"
github "alfred",          "1.5.0"
github "aspell",          "0.0.1", :repo => "namesco/puppet-aspell"
github "atom",            "1.3.0"
github "autoconf",        "1.0.0"
github "codekit",         "1.0.5"
github "colloquy",        "1.0.0"
github "dropbox",         "1.4.1"
github "filezilla",       "1.0.0", :repo => "dieterdemeyer/puppet-filezilla"
github "flux",            "1.0.1"
github "gimp",            "1.0.1"
github "github_for_mac",  "1.0.3"
github "graphviz",        "1.0.0"
github "imap",            "1.0.2", :repo => "namesco/puppet-imap"
github "iterm2",          "1.2.5"
github "java",            "1.8.4"
github "keepassx",        "1.0.0"
github "libpng",          "1.0.0"
github "libtool",         "1.0.0"
github "memcached",       "1.4.4", :repo => "namesco/puppet-memcached"
github "mod_fcgid",       "1.0.0", :repo => "namesco/puppet-mod_fcgid"
github "mongodb",         "3.0.7", :repo => "envato/puppet-mongodb"
github "mysql",           "1.99.25", :repo => "namesco/puppet-mysql"
github "mysql_workbench", "1.0.0", :repo => "cdburgess/puppet-mysql_workbench"
github "netbeans",        "1.0.1"
github "omnigraffle",     "1.3.1"
github "onepassword",     "1.1.5"
github "opera",           "0.3.3"
github "osx",             "2.8.0"
github "pcre",            "1.0.0"
github "php",             "2.0.42", :repo => "namesco/puppet-php"
github "python",          "3.0.2", :repo => "mloberg/puppet-python"
github "rabbitmq",        "0.2.3", :repo => "namesco/puppet-rabbitmq"
github "recursive_directory", "0.0.2", :repo => "namesco/puppet-recursive_directory"
github "redis",           "4.0.2"
github "reggy",           "1.0.2"
github "sourcetree",      "1.0.0"
github "steam",           "1.0.1"
github "swig",            "1.0.0"
github "sublime_text",    "1.1.0"
github "sublime_text_3",  "1.0.3", :repo => "jozefizso/puppet-sublime_text_3"
github "textexpander",    "1.1.0"
github "textmate",        "1.1.0"
github "textwrangler",    "1.0.7", :repo => "namesco/puppet-textwrangler"
github "thunderbird",     "1.4.0"
github "totalfinder",     "1.0.1"
github "transmit",        "1.0.2"
github "vagrant",         "3.3.4"
github "virtualbox",      "1.0.15", :repo => "namesco/puppet-virtualbox"
github "wget",            "1.0.1"
