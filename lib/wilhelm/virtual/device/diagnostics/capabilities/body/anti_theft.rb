# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module Body
            module AntiTheft
              HOOD_CONTACT = '00 18 01'
              GLOVE_BOX_CONTACT = '00 1A 01'
              INT_PROTECTION = '00 1B 01'
              TILT_INPUT = '00 1E 01'
              TILT_OUTPUT = '00 3D 01'
              ANTI_THEFT = '00 3C 01'
              STARTER_ENABLE = '00 3E 01'
              IMMOBILIZER = '00 51 01'
            end
          end
        end
      end
    end
  end
end
