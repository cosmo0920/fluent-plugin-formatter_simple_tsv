# fluent-plugin-formatter_simple_tsv

[![Build Status](https://travis-ci.org/cosmo0920/fluent-plugin-formatter_simple_tsv.svg?branch=master)](https://travis-ci.org/cosmo0920/fluent-plugin-formatter_simple_tsv)

Fluentd Simple TSV formatter plugin

## Notice

0.1.0 had been dropped support Fluentd v0.12.
If you want to use this plugin with Fluentd v0.12, please add version constraint in your Gemfile like as:

```ruby
gem "fluent-plugin-formatter_simple_tsv", "~> 0.0.3"
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fluent-plugin-formatter_simple_tsv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-formatter_simple_tsv

## Configuration Example

Use out_xxx plugins which support Formatter feature together.

For example, for out_file plugin:

```
<match raw.**>
  @type file
  path /tmp/tsv_test
  <format>
    @type simple_tsv
    keys key1,key2
  </format>
</match>
```
## Parameters

- **keys** (String. required) Specify "key1,key2,key3" format. This field is interpret ["key1", "key2", "key3"] internally. Only specified key's value will be formatted.

**Notice:** In v0.14 supported version of this plugin, handling tag and time feature has been removed.

## Development

After checking out the repo, run `bundle install` to install dependencies.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `fluent-plugin-formatter_simple_tsv.gemspec`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/cosmo0920/fluent-plugin-formatter_simple_tsv/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
