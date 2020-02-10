# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module GM
            module Activate
              # Diagnostics::Capabilities::GM::Activate::Constants
              module Constants
                # GENERAL MODULE (GM)
                SWITCH_WINDOW_DRIVER_OPEN     = [0x00, 0x00, 0x01].freeze
                SWITCH_WINDOW_DRIVER_CLOSE    = [0x00, 0x01, 0x01].freeze

                SWITCH_WIPER_INTENSIVE_PUMP   = [0x00, 0x02, 0x01].freeze

                SWITCH_WINDOW_PASS_OPEN       = [0x00, 0x03, 0x01].freeze
                SWITCH_WINDOW_PASS_CLOSE      = [0x00, 0x04, 0x01].freeze

                SWITCH_REAR_WINDOW            = [0x00, 0x07, 0x01].freeze
                SWITCH_TAILGATE_INSIDE        = [0x00, 0x08, 0x01].freeze
                SWITCH_TAILGATE               = [0x00, 0x09, 0x01].freeze

                CONTACT_TAILGATE              = [0x00, 0x0a, 0x01].freeze

                SWITCH_CENTRAL_LOCK           = [0x00, 0x0b, 0x01].freeze

                CONTACT_DOOR_DRIVER_FRONT     = [0x00, 0x10, 0x01].freeze
                CONTACT_DOOR_PASS_FRONT       = [0x00, 0x11, 0x01].freeze
                CONTACT_DOOR_DRIVER_REAR      = [0x00, 0x12, 0x01].freeze
                CONTACT_DOOR_PASS_REAR        = [0x00, 0x13, 0x01].freeze

                SWITCH_WIPER_1                = [0x00, 0x14, 0x01].freeze
                SWITCH_WIPER_2                = [0x00, 0x15, 0x01].freeze
                SWITCH_WIPER_WASH             = [0x00, 0x16, 0x01].freeze

                SWITCH_INTERIOR_LIGHTS        = [0x00, 0x17, 0x01].freeze

                CONTACT_BONNET                = [0x00, 0x18, 0x01].freeze
                CONTACT_GLOVE_BOX             = [0x00, 0x1a, 0x01].freeze

                CONTACT_WINDOW_REAR           = [0x00, 0x1d, 0x01].freeze

                RELAY_WIPERS_STAGE_1          = [0x00, 0x38, 0x01].freeze
                RELAY_WIPERS_STAGE_2          = [0x00, 0x39, 0x01].freeze

                RELAY_HEADLIGHT_WASH_PUMP     = [0x00, 0x3a, 0x01].freeze
                RELAY_INTENSIVE_PUMP          = [0x00, 0x3b, 0x01].freeze

                DWA_LED                       = [0x00, 0x3c, 0x01].freeze
                STARTER_ENABLE                = [0x00, 0x3e, 0x01].freeze

                RELAY_CENTRAL_LOCK            = [0x00, 0x41, 0x01].freeze
                RELAY_CENTRAL_UNLOCK          = [0x00, 0x42, 0x01].freeze
                RELAY_CENTRAL_SECURE          = [0x00, 0x42, 0x01].freeze

                RELAY_WIN_DRIVER_REAR_CLOSE   = [0x00, 0x44, 0x01].freeze
                RELAY_WIN_DRIVER_REAR_OPEN    = [0x00, 0x45, 0x01].freeze
                RELAY_WIN_PASS_REAR_CLOSE     = [0x00, 0x46, 0x01].freeze
                RELAY_WIN_PASS_REAR_OPEN      = [0x00, 0x47, 0x01].freeze

                RELAY_WASHER_PUMP             = [0x00, 0x4b, 0x01].freeze

                CONSUMER_SHUTDOWN             = [0x00, 0x50, 0x01].freeze

                # Unverified
                IMMOBILIZER_ON                = [0x00, 0x51, 0x01].freeze
                IMMOBILIZER_OFF               = [0x00, 0x51, 0x00].freeze

                # Type = PS
                ZV_SWITCH_PACKAGE_FT_LOCK     = [0x00, 0x88, 0x01].freeze
                ZV_SWITCH_PACKAGE_BT_LOCK     = [0x00, 0x98, 0x01].freeze

                # Type = KS
                TERMINAL_R                    = [0x00, 0xA8, 0x01].freeze
                TERMINAL_15                   = [0x00, 0xA9, 0x01].freeze
                TERMINAL_50                   = [0x00, 0xAA, 0x01].freeze

                LOCKING_FBZV_KS               = [0x00, 0xb1, 0x01].freeze

                TERMINAL_58                   = [0x00, 0xc1, 0x01].freeze

                # Unconfirmed, but verified in old notes.
                # Presumably windows?
                # REAR_OPEN                     = [0x00, 0x64, 0x01].freeze
                # FRONT_OPEN                    = [0x00, 0x65, 0x01].freeze
                # SUNROOF_OPEN                  = [0x00, 0x66, 0x01].freeze

                # DRIVER DOOR MODULE (FT)

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

                # PASSENGER

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

                # DRIVER

                SEAT_FORWARD                  = [0x05, 0x00, 0x01].freeze
                SEAT_BACK                     = [0x05, 0x01, 0x01].freeze
                SEAT_UP                       = [0x05, 0x02, 0x01].freeze
                SEAT_DOWN                     = [0x05, 0x03, 0x01].freeze
                SEAT_TILT_BACK                = [0x05, 0x04, 0x01].freeze
                SEAT_TILT_FORWARD             = [0x05, 0x05, 0x01].freeze
                SEAT_BACKREST_BACK            = [0x05, 0x06, 0x01].freeze
                SEAT_BACKREST_FORWARD         = [0x05, 0x07, 0x01].freeze
                SEAT_HEADREST_UP              = [0x05, 0x08, 0x01].freeze
                SEAT_HEADREST_DOWN            = [0x05, 0x09, 0x01].freeze
                # SEAT_THIGH_BACK?            = [0x05, 0x0a, 0x01].freeze
                # SEAT_THIGH_FORWARD?         = [0x05, 0x0b, 0x01].freeze
                SEAT_SHOULDER_BACK            = [0x05, 0x0c, 0x01].freeze
                SEAT_SHOULDER_FORWARD         = [0x05, 0x0d, 0x01].freeze

                STEERING_UP                   = [0x05, 0x0e, 0x01].freeze
                STEERING_DOWN                 = [0x05, 0x0f, 0x01].freeze
                STEERING_IN                   = [0x05, 0x10, 0x01].freeze
                STEERING_OUT                  = [0x05, 0x11, 0x01].freeze
              end
            end
          end
        end
      end
    end
  end
end
