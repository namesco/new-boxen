# Atom Puppet Module for Boxen

Install [Atom](http://atom.io), hackable text editor for the 21st Century

[![Build Status](https://travis-ci.org/boxen/puppet-atom.svg?=master)](https://travis-ci.org/boxen/puppet-atom)

## Usage

```puppet
include atom

# install the linter package
atom::package { 'linter': }

# install the monokai theme
atom::theme { 'monokai': }
```

## Required Puppet Modules

* `boxen`
* `stdlib`
* `brewcask`

## Development

Set `GITHUB_API_TOKEN` in your shell with a [Github oAuth Token](https://help.github.com/articles/creating-an-oauth-token-for-command-line-use) to raise your API rate limit. You can get some work done without it, but you're less likely to encounter errors like `Unable to find module 'boxen/puppet-boxen' on https://github.com`.

Then write some code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
