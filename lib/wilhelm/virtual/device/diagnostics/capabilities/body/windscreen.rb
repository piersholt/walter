# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module Body
            module Windscreen
              CLEAN = '00 02 01'
              # WIPER = '49 01' - doesn't work
              # FLUID = '62 01' - don't work
            end
          end
        end
      end
    end
  end
end
