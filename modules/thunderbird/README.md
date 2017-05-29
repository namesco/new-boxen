# Thunderbird Puppet Module for Boxen [![Build Status](https://travis-ci.org/boxen/puppet-thunderbird.png)](https://travis-ci.org/boxen/puppet-thunderbird)

Install [Thunderbird](https://www.mozilla.org/en-US/thunderbird/), a free email application.

## Usage

```puppet
include thunderbird
```
or with version and locale specification

```puppet
class { 'thunderbird':
  version => '24.3.0',
  locale  => 'fr',
}
```

## Required Puppet Modules

* `boxen`

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
