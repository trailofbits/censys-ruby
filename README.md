# CenSys

* [Homepage](https://github.com/trailofbits/censys-ruby#readme)
* [Issues](https://github.com/trailofbits/censys-ruby/issues)
* [Documentation](http://rubydoc.info/gems/censys/frames)

## Description

Ruby API client to the [CenSys] internet search engine.

## Features

## Examples

Initialize the API:

    require 'censys'
    api = CenSys::API.new(uid,secret)

Initialize the API using `$CENSYS_ID` and `$CENSYS_SECRET` environment
variables:

    api = CenSys::API.new

Search for IPv4 addresses:

    response = api.ipv4.search(query: 'dropbox.com')

Search for Websites:

    response = api.websites.search(query: 'dropbox.com')

Search for Certificates:

    response = api.certificates.search(query: 'dropbox.com')

Enumerate through search results:

    response.each_page do |page|
      puts ">>> Page ##{page.metadata.page} / #{page.metadata.pages} ..."

      page.each do |result|
        puts result
      end
    end

Generate aggregate reports:

    response = api.websites.report(
      query: '80.http.get.headers.server: Apache',
      field: 'location.country_code',
      buckets: 100
    )

    response.each do |country,count|
      puts "#{country}: #{count}"
    end

## Requirements

* [ruby] >= 2.0

## Install

    $ gem install censys

## Copyright

Copyright (c) 2016 Hal Brodigan

See {file:LICENSE.txt} for details.

[ruby]: http://www.ruby-lang.org/
[CenSys]: https://censys.io/
