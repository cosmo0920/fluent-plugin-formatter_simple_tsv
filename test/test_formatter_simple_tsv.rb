require_relative 'test_helper'

class SimpleTsvFormatterTest < ::Test::Unit::TestCase
  def setup
    @formatter = Fluent::Plugin.new_formatter('simple_tsv')
    @time = Fluent::Engine.now
    @tag = 'tag'
  end

  def e(name, arg='', attrs={}, elements=[])
    Fluent::Config::Element.new(name, arg, attrs, elements)
  end

  def configure(conf)
    @formatter.configure(e('ROOT', '', {}.merge(conf)))
  end

  def test_format_empty_configure
    assert_raise Fluent::ConfigError do
      configure({})
    end
  end

  def test_config_params
    formatter = Fluent::Plugin.new_formatter('simple_tsv')
    assert_equal([], formatter.keys)

    conf = e('ROOT', '', {'keys' => 'key1,key2'})
    formatter.configure(conf)

    assert_equal(["key1", "key2"], formatter.keys)
  end


  def test_format
    configure('keys' => 'key1,key2')
    formatted = @formatter.format(@tag, @time, {
                                    'key1' => 'awesome',
                                    'key2' => 'awesome2'
                                  })
    assert_equal("awesome\tawesome2\n", formatted)
  end

  def test_format_keys
    configure('keys' => 'key1,key3')
    formatted = @formatter.format(@tag, @time, {
                                    'key1' => 'awesome',
                                    'key2' => 'awesome2',
                                    'key3' => 'awesome3',
                                  })
    assert_equal("awesome\tawesome3\n", formatted)
  end

  def test_format_with_time
    configure('keys' => 'key1,key3',
              'include_time_key' => 'true',
              'time_format' => '%Y')
    formatted = @formatter.format(@tag, @time, {
                                    'key1' => 'awesome',
                                    'key2' => 'awesome2',
                                    'key3' => 'awesome3',
                                  })
    assert_equal("awesome\tawesome3\t#{Time.now.year}\n", formatted)
  end

  def test_format_with_tag
    configure('keys' => 'key1,key3',
              'include_tag_key' => 'true')
    formatted = @formatter.format(@tag, @time, {
                                    'key1' => 'awesome',
                                    'key2' => 'awesome2',
                                    'key3' => 'awesome3',
                                  })
    assert_equal("awesome\tawesome3\ttag\n", formatted)
  end

  def test_format_with_tag_and_time
    configure('keys' => 'key1,key3',
              'include_tag_key' => 'true',
              'include_time_key' => 'true',
              'time_format' => '%Y')
    formatted = @formatter.format(@tag, @time, {
                                    'key1' => 'awesome',
                                    'key2' => 'awesome2',
                                    'key3' => 'awesome3',
                                  })
    assert_equal("awesome\tawesome3\ttag\t#{Time.now.year}\n", formatted)
  end
end
