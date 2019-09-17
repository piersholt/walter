# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        # Virtual::Command::Parameterized::Base
        class Base < Base
          def to_s
            "#{sn}\t#{format_things}"
          end

          def format_things
            result = parameters.map do |param|
              next nil if public_send(param).nil?
              format_thing(param)
            end
            result&.compact&.join(' / ')
          end

          def format_thing(param_name)
            param_object = public_send(param_name)
            value = param_object.value
            value = value.kind_of?(Numeric) ? d2h(value, true) : value
            "#{param_name}: #{value} (#{param_object.to_s})"
          end

          def inspect
            return to_s
          end
        end
      end
    end
  end
end
