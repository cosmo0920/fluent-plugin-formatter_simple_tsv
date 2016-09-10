require 'fluent/plugin/formatter'

module Fluent
  module Plugin
    class SimpleTsvFormatter < Formatter
      Fluent::Plugin.register_formatter('simple_tsv', self)

      config_param :keys, :default => [] do |val|
        val.split(',')
      end

      def configure(conf)
        super

        if @keys.empty?
          raise Fluent::ConfigError, "keys option is required on simple_tsv formatter"
        end
      end

      def format(tag, time, record)
        selected = record.select {|key, val|
          @keys.include?(key)
        }
        formatted = selected.inject('') { |result, pair|
          result << "\t" if result.length.nonzero?
          result << "#{pair.last}"
        }
        formatted << "\n"
        formatted
      end
    end
  end
end
