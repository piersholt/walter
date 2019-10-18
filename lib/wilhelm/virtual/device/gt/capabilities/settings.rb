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

            def range?(range, *values)
              values.all? { |i| range.cover?(i) }
            end
          end
        end
      end
    end
  end
end
