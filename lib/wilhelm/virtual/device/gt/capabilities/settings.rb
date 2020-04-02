# frozen_string_literal: false

require_relative 'settings/brightness'
require_relative 'settings/date'
require_relative 'settings/memo'
require_relative 'settings/time'

module Wilhelm
  module Virtual
    class Device
      module GT
        module Capabilities
          # Settings interface controls
          module Settings
            include Time
            include Date
            include Memo
            include Brightness

            def integers?(*integers)
              integers.all? { |i| i.is_a?(Integer) }
            end

            def negative?(*integers)
              integers.any?(&:negative?)
            end

            def valid_range?(range, *values)
              values.all? { |i| range.cover?(i) }
            end

            include API
            include Helpers::Data

            # obc_var(field: FIELD_CODE, input: code_byte_array)
            def input(field = 0x00, input = genc(10))
              obc_var(field: field, input: input)
            end

            def output(field = 0x00, chars = genc(10))
              anzv_var(field: field, ike: 0x30, chars: chars)
            end
          end
        end
      end
    end
  end
end
