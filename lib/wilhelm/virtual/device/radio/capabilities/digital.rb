# frozen_string_literal: true

require_relative 'digital/display'

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          # RDS/Digital
          module RDS
            include Display
          end
        end
      end
    end
  end
end
