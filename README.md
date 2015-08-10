# fluent-plugin-formatter_simple_tsv

[![Build Status](https://travis-ci.org/cosmo0920/fluent-plugin-formatter_simple_tsv.svg?branch=master)](https://travis-ci.org/cosmo0920/fluent-plugin-formatter_simple_tsv)

Fluentd Simple TSV formatter plugin

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fluent-plugin-formatter_simple_tsv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-formatter_simple_tsv

Or using `fluent-gem` command as:

    $ fluent-gem install fluent-plugin-formatter_simple_tsv

## Configuration Example

Use out_xxx plugins which support Formatter feature together.

For example, for out_file plugin:

```
<match raw.**>
  type file
  path /tmp/tsv_test
  format simple_tsv
  keys key1,key2
</match>
```
## Parameters

- **keys** (String. required) Specify "key1,key2,key3" format. This field is interpret ["key1", "key2", "key3"] internally. Only specified key's value will be formatted.
- **include_time_key** (Boolean, Optional, defaults to false) If true, the time field (as specified by the time_key parameter) is kept in the record.
- **time_key** (String, xOptional, defaults to “time”) The field name for the time key.
- **time_format** (String. Optional) By default, the output format is iso8601 (e.g. “2008-02-01T21:41:49”). One can specify their own format with this parameter.
- **include_tag_key** (Boolean. Optional, defaults to false) If true, the tag field (as specified by the tag_key parameter) is kept in the record.
- **tag_key** (String, Optional, defaults to “tag”) The field name for the tag key.
- **localtime** (Boolean. Optional, defaults to true) If true, use local time. Otherwise, UTC is used. This parameter is overwritten by the utc parameter.
- **timezone** (String. Optional. v0.10.56 and above) By setting this parameter, one can parse the time value in the specified timezone. The following formats are accepted:

    1. [+–]HH:MM (e.g. “+09:00”)
    1. [+–]HHMM (e.g. “+0900”)
    1. [+–]HH (e.g. “+09”)
    1. Region/Zone (e.g. “Asia/Tokyo”)
    1. Region/Zone/Zone (e.g. “America/Argentina/Buenos_Aires”)

  The timezone set in this parameter takes precedence over localtime, e.g., if localtime is set to true but timezone is set to +0000, UTC would be used.

## Development

After checking out the repo, run `bundle install` to install dependencies.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/cosmo0920/fluent-plugin-formatter_simple_tsv/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
