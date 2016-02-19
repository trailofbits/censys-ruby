# CenSys

* [Homepage](https://github.com/trailofbits/censys-ruby#readme)
* [Issues](https://github.com/trailofbits/censys-ruby/issues)
* [Documentation](http://rubydoc.info/gems/censys/frames)

## Description

Ruby API client to the [CenSys] internet search engine.

## Features

## Examples

    require 'censys'

    api = CenSys::API.new(uid,secret)

    api.search(:ipv4, query: 'dropbox.com')

## Requirements

* [ruby] >= 2.0

## Install

    $ gem install censys

## Copyright

Copyright (c) 2016 Hal Brodigan

See {file:LICENSE.txt} for details.

[ruby]: http://www.ruby-lang.org/
[CenSys]: https://censys.io/
