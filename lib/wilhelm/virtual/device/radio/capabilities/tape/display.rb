# frozen_string_literal: true

require_relative 'display/dolby'

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module Tape
            # Tape Radio Display
            module Display
              include API
              include Constants

              include Dolby
            end
          end
        end
      end
    end
  end
end
