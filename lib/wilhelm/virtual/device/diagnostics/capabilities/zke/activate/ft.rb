# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module ZKE
            module Activate
              # Diagnostics::Capabilities::GM::Activate::FT
              module FT
                DRIVER_KEY_TUMBLER_LOCK       = [0x01, 0x00, 0x01].freeze
                DRIVER_KEY_TUMBLER_UNLOCK     = [0x01, 0x03, 0x01].freeze

                DRIVER_MEMORY_1               = [0x01, 0x08, 0x01].freeze
                DRIVER_MEMORY_2               = [0x01, 0x09, 0x01].freeze
                DRIVER_MEMORY_3               = [0x01, 0x0a, 0x01].freeze

                # DRIVER_MIRROR_UNFOLD        = [0x01, 0x30, 0x01].freeze
                # DRIVER_MIRROR_FOLD          = [0x01, 0x31, 0x01].freeze

                RELAY_DRIVER_WINDOW_CLOSE     = [0x01, 0x32, 0x01].freeze
                RELAY_DRIVER_WINDOW_OPEN      = [0x01, 0x36, 0x01].freeze

                DRIVER_DOOR_LOCK              = [0x01, 0x39, 0x01].freeze
                DRIVER_DOOR_UNLOCK            = [0x01, 0x3a, 0x01].freeze

                DRIVER_MIRROR_DOWN            = [0x01, 0x3b, 0x01].freeze
                DRIVER_MIRROR_UP              = [0x01, 0x3c, 0x01].freeze
                DRIVER_MIRROR_RIGHT           = [0x01, 0x3d, 0x01].freeze
                DRIVER_MIRROR_LEFT            = [0x01, 0x3e, 0x01].freeze

                DRIVER_MEMORY_SWITCH          = [0x01, 0x44, 0x01].freeze
              end
            end
          end
        end
      end
    end
  end
end
