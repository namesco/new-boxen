# TextWrangler
[![Build
Status](https://travis-ci.org/boxen/puppet-textwrangler.png?branch=master)](https://travis-ci.org/boxen/puppet-textwrangler)

Installs [TextWrangler](http://www.barebones.com/products/textwrangler/).

A free text editor from Bare Bones.

## Usage:

``` puppet
include textwrangler
```

**Note**: Right now this does not install cmd tools so you will have to run that from the app menu on your own. 

## Required Puppet Modules

* `boxen`

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
