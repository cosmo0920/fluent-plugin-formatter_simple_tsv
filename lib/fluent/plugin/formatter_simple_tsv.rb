module Fluent
  module TextFormatter
    class SimpleTsvFormatter < Formatter
      Plugin.register_formatter('simple_tsv', self)

      include Configurable
      include HandleTagAndTimeMixin

      config_param :keys, :default => [] do |val|
        val.split(',')
      end

      def configure(conf)
        super

        if @keys.empty?
          raise ConfigError, "keys option is required on simple_tsv formatter"
        end
      end

      def format(tag, time, record)
        selected = record.select {|key, val|
          @keys.include?(key)
        }
        filter_record(tag, time, selected)
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
