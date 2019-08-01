# frozen_string_literal: false

module Wilhelm
  module Virtual
    # Virtual::BitArrayParameter
    class BitArrayParameter < BaseParameter
      PROC = 'BitArrayParam'.freeze

      attr_reader :parameters, :index, :bit_array, :indexed_bit_array

      def initialize(config, numeric)
        LOGGER.debug(PROC) { "#initialize(#{config}, #{numeric})" }
        super(config, numeric)

        parse_bit_array_parameters(config, numeric)
      end

      def to_s
        params = aligned_parameters
        params = params.compact
        params = params.join(' ')

        str_buffer = ''
        str_buffer.concat('(')
        str_buffer.concat(@bit_array.to_s)
        str_buffer.concat(') ')
        str_buffer.concat("#{params}")
      end

      def inspect
        params = aligned_parameters
        params = params.compact
        params = params.join(', ')

        str_buffer = "<#{PROC} #{bit_array} params: #{parameter_list}"
        str_buffer.concat("[#{params}]")
        str_buffer.concat('>')
      end

      def aligned_parameters
        parameters.values.map(&:to_s)
      end

      def labels
        parameters.values.map(&:label).compact
      end

      def label_width
        return @label_width unless @label_width.nil?
        longest_label = labels.max do |p1, p2|
          p1.length <=> p2.length
        end

        @label_width = longest_label.length
        @label_width
      end

      private

      def parse_bit_array_parameters(parameter_config, numeric)
        begin
          @bit_array = BitArray.from_i(numeric)
          return false unless parameter_config.has_parameters?
          @indexed_bit_array = IndexedBitArray.new(@bit_array, parameter_config.index)
          @parameters = {}

          parameter_config.parameters.each do |bit_array_param_name, bit_array_param_config|
            var_name = inst_var(bit_array_param_name)
            param_value = @indexed_bit_array.lookup(bit_array_param_name)
            param_type  = bit_array_param_config.type

            param_object = DelegatedCommandParameter.create(bit_array_param_config, param_type, param_value)
            bit_array_param_config.configure(param_object)

            param_object.instance_variable_set(var_name, param_object)
            @parameters[bit_array_param_name] = param_object
          end
        rescue StandardError => e
          LOGGER.error(PROC) { "#{e}" }
          e.backtrace.each { |l| LOGGER.error(l) }
          binding.pry
        end
      end


      def parameter_list
        if @parameters.nil?
          LOGGER.debug(PROC) { "@parameters not set! @parameters=#{@parameters}" }
          # .map { |p| instance_variable_get(inst_var(p)) }.join(', ')
          return []
        end
        @parameters.keys
      end
    end
  end
end
