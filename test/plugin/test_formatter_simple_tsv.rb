require_relative '../test_helper'
require 'fluent/test/driver/formatter'

class SimpleTsvFormatterTest < ::Test::Unit::TestCase
  include Fluent::PluginHelper::Mixin

  def setup
    @formatter = create_driver
    @time = Fluent::Engine.now
    @tag = 'tag'
  end

  def create_driver(conf={})
    Fluent::Test::Driver::Formatter.new(Fluent::Plugin::SimpleTsvFormatter)
  end

  def configure(conf)
    @formatter.configure({}.merge(conf))
  end

  def test_format_empty_configure
    assert_raise Fluent::ConfigError do
      configure({})
    end
  end

  def test_config_params
    formatter = create_driver
    assert_equal([], formatter.instance.keys)

    conf = {'keys' => 'key1,key2'}
    formatter.configure(conf)

    assert_equal(["key1", "key2"], formatter.instance.keys)
  end


  def test_format
    configure('keys' => 'key1,key2')
    formatted = @formatter.instance.format(@tag, @time, {
                                             'key1' => 'awesome',
                                             'key2' => 'awesome2'
                                           })
    assert_equal("awesome\tawesome2\n", formatted)
  end

  def test_format_keys
    configure('keys' => 'key1,key3')
    formatted = @formatter.instance.format(@tag, @time, {
                                             'key1' => 'awesome',
                                             'key2' => 'awesome2',
                                             'key3' => 'awesome3',
                                           })
    assert_equal("awesome\tawesome3\n", formatted)
  end
end
