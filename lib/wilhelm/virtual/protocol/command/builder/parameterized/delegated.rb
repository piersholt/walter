# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      class Builder
        class Parameterized < Builder
          # Virtual::Command::Builder::Parameterized::Delegated
          module Delegated
            include Helpers

            PROG = 'Builder::Parameterized::Delegated'.freeze

            TYPE_CLASS_MAP = {
              switch:    'Wilhelm::Virtual::SwitchedParameter',
              map:       'Wilhelm::Virtual::MappedParameter',
              chars:     'Wilhelm::Virtual::CharsParameter',
              bit_array: 'Wilhelm::Virtual::BitArrayParameter',
              data:      'Wilhelm::Virtual::DataParameter',
              integer:   'Wilhelm::Virtual::BaseParameter',
              default:   'Wilhelm::Virtual::BaseParameter'
            }.freeze

            def delegate(configuration, type, value)
              LOGGER.debug(PROG) { "#delegate(#{configuration}, #{type}, #{value})" }
              valid_type?(type)
              klass = get_class(TYPE_CLASS_MAP[type])
              klass.new(configuration, value)
            rescue StandardError => e
              LOGGER.error(PROG) { e }
              e.backtrace.each { |line| LOGGER.error(PROG) { line } }
              binding.pry
            end

            private

            def valid_type?(type)
              return true if TYPE_CLASS_MAP.key?(type)
              raise(
                ArgumentError,
                "wtf is #{type ? type : 'no type!'} or this bullshit " \
                "klass_string #{klass_string ? klass_string : 'blank!' }"
              )
            end
          end
        end
      end
    end
  end
end
