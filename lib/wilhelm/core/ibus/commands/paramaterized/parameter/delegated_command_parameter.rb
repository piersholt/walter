# frozen_string_literal: false

module Wilhelm
  module Core
    module DelegatedCommandParameter
      include Helpers
      PROC = 'DelCommandParam'

      MAP = :map
      SWITCH = :switch
      BIT_ARRAY = :bit_array
      CHARS = :chars
      INTEGER = :integer
      # PARAMETERS_TO_SETUP = [MAP, BIT_ARRAY, SWITCH].freeze

      TYPE_CLASS_MAP =
      { SWITCH => 'Wilhelm::Core::SwitchedParameter',
        MAP => 'Wilhelm::Core::MappedParameter',
        CHARS => 'Wilhelm::Core::CharsParameter',
        BIT_ARRAY => 'Wilhelm::Core::BitArrayParameter',
        default:  'Wilhelm::Core::BaseParameter' }

        def self.create(configuration, type, value)
          LOGGER.debug(PROC) { "#create(#{configuration}, #{type}, #{value})" }
          case type
          when MAP
            klass_string = TYPE_CLASS_MAP[MAP]
          when SWITCH
            klass_string = TYPE_CLASS_MAP[SWITCH]
          when BIT_ARRAY
            klass_string = TYPE_CLASS_MAP[BIT_ARRAY]
          when CHARS
            klass_string = TYPE_CLASS_MAP[CHARS]
          when INTEGER
            klass_string = TYPE_CLASS_MAP[:default]
          else
            raise ArgumentError, "wtf is #{type ? type : 'no type!'} or this bullshit klass_string #{klass_string ? klass_string : 'blank!' }"
          end

          klass = Helpers.get_class(klass_string)
          begin
            klass.new(configuration, value)
          rescue StandardError => e
            LOGGER.error(PROC) { "#{e}" }
            e.backtrace.each { |l| LOGGER.error(l) }
            binding.pry
          end
        end
      end
  end
end
