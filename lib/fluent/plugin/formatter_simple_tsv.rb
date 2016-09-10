require 'fluent/plugin/formatter'

module Fluent
  module Plugin
    module Inject
      module Mixin
        require 'fluent/plugin_helper'
        include Fluent::PluginHelper::Mixin

        helpers :inject, :compat_parameters
      end
    end
  end
end

module Fluent
  module Plugin
    class SimpleTsvFormatter < Formatter
      Fluent::Plugin.register_formatter('simple_tsv', self)

      include Plugin::Inject::Mixin

      config_param :keys, :default => [] do |val|
        val.split(',')
      end

      def configure(conf)
        compat_parameters_convert(conf, :inject)
        super

        if @keys.empty?
          raise Fluent::ConfigError, "keys option is required on simple_tsv formatter"
        end
      end

      def format(tag, time, record)
        selected = record.select {|key, val|
          @keys.include?(key)
        }
        injected = inject_values_to_record(tag, time, selected)
        formatted = injected.inject('') { |result, pair|
          result << "\t" if result.length.nonzero?
          result << "#{pair.last}"
        }
        formatted << "\n"
        formatted
      end
    end
  end
end
