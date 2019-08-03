# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      class Configuration
        # Virtual::BitArrayParameterConfiguration
        class BitArray < Parameter
          PROC = 'Configuration::BitArray'.freeze

          attr_reader :parameters

          def initialize(parameter_name, parameter_hash)
            super(parameter_name, parameter_hash)
            parse_parameters(parameters_hash) if parameters?
          end

          def inspect
            "<#{PROC} @type=#{type} @parameter_list=#{parameter_list}>"
          end

          def to_s
            "<#{PROC} @type=#{type} @parameter_list=#{parameter_list}>"
          end

          # Initialization --------------------------------------------------------

          def parse_parameters(mapped_parameters)
            LOGGER.debug(PROC) { "#parse_parameters(#{mapped_parameters})" }
            @parameters = {}
            mapped_parameters.each do |name, data|
              new_parameter = Parameter.new(name, data)
              @parameters[name] = new_parameter
            end
          rescue StandardError => e
            LOGGER.error(PROC) { e }
            e.backtrace.each { |line| LOGGER.error(PROC) { line } }
            binding.pry
          end

          # Command Hash ----------------------------------------------------------

          def index
            @parameter_hash[:index]
          end

          def parameters_hash
            @parameter_hash[:parameters]
          end

          # Configuration ---------------------------------------------------------

          def parameters?
            parameters_hash.nil? ? false : true
          end

          def parameter_list
            parameters_hash&.keys
          end

          def bit_array?
            true
          end
        end
      end
    end
  end
end
