# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module ZKE
            module Activate
              # Diagnostics::Capabilities::GM::Activate::SD
              module SD
                # Unconfirmed, but verified in old notes.
                # Presumably windows?
                # REAR_OPEN                     = [0x00, 0x64, 0x01].freeze
                # FRONT_OPEN                    = [0x00, 0x65, 0x01].freeze
                # SUNROOF_OPEN                  = [0x00, 0x66, 0x01].freeze
              end
            end
          end
        end
      end
    end
  end
end
