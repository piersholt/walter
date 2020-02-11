# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module ZKE
            module Activate
              # Diagnostics::Capabilities::GM::Activate::BT
              module BT
                # PASS_MIRROR_UNFOLD            = [0x02, 0x30, 0x01].freeze
                # PASS_MIRROR_FOLD              = [0x02, 0x31, 0x01].freeze

                PASS_WINDOW_CLOSE             = [0x02, 0x32, 0x01].freeze
                PASS_WINDOW_OPEN              = [0x02, 0x36, 0x01].freeze

                PASS_DOOR_LOCK                = [0x02, 0x39, 0x01].freeze
                PASS_DOOR_UNLOCK              = [0x02, 0x3a, 0x01].freeze

                PASS_MIRROR_DOWN              = [0x02, 0x3b, 0x01].freeze
                PASS_MIRROR_UP                = [0x02, 0x3c, 0x01].freeze
                PASS_MIRROR_RIGHT             = [0x02, 0x3d, 0x01].freeze
                PASS_MIRROR_LEFT              = [0x02, 0x3e, 0x01].freeze
              end
            end
          end
        end
      end
    end
  end
end
