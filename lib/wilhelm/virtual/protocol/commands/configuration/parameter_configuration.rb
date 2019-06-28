# frozen_string_literal: false

module Wilhelm
  module Virtual
    class ParameterConfiguration
      include Helpers
      PROC = 'ParamConfig'.freeze
      MAP = :map
      SWITCH = :switch
      BIT_ARRAY = :bit_array
      CHARS = :chars
      INTEGER = :integer
      DATA = :data
      TYPES = [MAP, BIT_ARRAY, SWITCH, CHARS, INTEGER, DATA].freeze

      PROPERTIES = {
        MAP => [:map, :dictionary, :label],
        SWITCH => [:label, :states],
        BIT_ARRAY => [],
        CHARS => [],
        DATA => [],
        INTEGER => [] }

        attr_reader :name, :type

        def initialize(parameter_name, parameter_hash)
          @name = parameter_name
          @parameter_hash = parameter_hash
        end

        def type
          @parameter_hash[:type]
        end

        def properties
          PROPERTIES[type]
        end

        def try_and_grab(name)
          @parameter_hash[name]
        end

        def inspect
          "<#{PROC} @name=#{name} @type=#{type}>"
        end

        def to_s
          "<#{PROC} @name=#{name} @type=#{type}>"
        end

        def is_bit_array?
          false
        end


        def configure(object)
          LOGGER.debug(PROC) { "Configure parameter #{object.class} with #{PROPERTIES[type]}" }

          # LOGGER.info(PROC) { "Setting #{object.class}: name = #{name}" }
          object.instance_variable_set(inst_var(:name), name)

          PROPERTIES[type].each do |property|
            var = inst_var(property)
            value = try_and_grab(property)
            LOGGER.debug(PROC) { "Setting #{object.class}: #{var} = #{value}" }
            next if value.nil?
            object.instance_variable_set(var, value)
          end
        end
      end
  end
end
