# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module Constants
            WINDOW_DRIVER_OPEN            = [0x00, 0x00, 0x01].freeze
            WINDOW_DRIVER_CLOSE           = [0x00, 0x01, 0x01].freeze
            WINDOW_PASS_OPEN              = [0x00, 0x03, 0x01].freeze
            WINDOW_PASS_CLOSE             = [0x00, 0x04, 0x01].freeze

            BUTTON_REAR_WINDOW            = [0x00, 0x07, 0x01].freeze
            BOOT_A                        = [0x00, 0x08, 0x01].freeze
            BOOT_B                        = [0x00, 0x08, 0x01].freeze
            BOOT_C                        = [0x00, 0x09, 0x01].freeze

            CONTACT_DOOR_DRIVER_FRONT     = [0x00, 0x10, 0x01].freeze
            CONTACT_DOOR_PASS_FRONT       = [0x00, 0x11, 0x01].freeze
            CONTACT_DOOR_DRIVER_REAR      = [0x00, 0x12, 0x01].freeze
            CONTACT_DOOR_PASS_REAR        = [0x00, 0x13, 0x01].freeze

            LIGHTS_INTERIOR_ON            = [0x00, 0x17, 0x01].freeze
            CONTACT_HOOD_OPEN             = [0x00, 0x18, 0x01].freeze
            # Unverified
            CONTACT_GLOVE_BOX             = [0x00, 0x1a, 0x01].freeze
            INTERIOR_PROTECTION           = [0x00, 0x1b, 0x01].freeze
            CONTACT_WINDOW_REAR           = [0x00, 0x1d, 0x01].freeze
            INPUT_TILT_ALARM_SENSOR       = [0x00, 0x1e, 0x01].freeze

            WIPERS_ON                     = [0x00, 0x38, 0x01].freeze
            ANTI_THEFT                    = [0x00, 0x3c, 0x01].freeze
            OUTPUT_TILT_ALARM_SENSOR      = [0x00, 0x3d, 0x01].freeze
            STARTER_ENABLE                = [0x00, 0x3e, 0x01].freeze

            REAR_DOORS_LOCK               = [0x00, 0x41, 0x01].freeze
            REAR_DOORS_UNLOCK             = [0x00, 0x42, 0x01].freeze

            WINDOW_DRIVER_REAR_CLOSE      = [0x00, 0x44, 0x01].freeze
            WINDOW_DRIVER_REAR_OPEN       = [0x00, 0x45, 0x01].freeze
            WINDOW_PASS_REAR_CLOSE        = [0x00, 0x46, 0x01].freeze
            WINDOW_PASS_REAR_OPEN         = [0x00, 0x47, 0x01].freeze

            IMMOBILIZER                   = [0x00, 0x51, 0x01].freeze

            # Activated central locking and comfort close.
            # Possible driver key cylinder?
            DRIVER_KEY_TUMBLER_LOCK       = [0x01, 0x00, 0x01].freeze
            DRIVER_KEY_TUMBLER_UNLOCK     = [0x01, 0x03, 0x01].freeze

            MEMORY_POS_1                  = [0x01, 0x08, 0x01].freeze
            MEMORY_POS_2                  = [0x01, 0x09, 0x01].freeze
            MEMORY_POS_3                  = [0x01, 0x0a, 0x01].freeze

            # Unconfirmed
            DRIVER_MIRROR_FOLD_OUT        = [0x01, 0x30, 0x01].freeze
            DRIVER_MIRROR_FOLD_IN         = [0x01, 0x31, 0x01].freeze
            # Random find?
            DRIVER_WINDOW_CLOSE           = [0x01, 0x32, 0x01].freeze
            DRIVER_WINDOW_OPEN            = [0x01, 0x36, 0x01].freeze

            DRIVER_DOOR_LOCK              = [0x01, 0x39, 0x01].freeze
            DRIVER_DOOR_UNLOCK            = [0x01, 0x3a, 0x01].freeze

            DRIVER_MIRROR_DOWN            = [0x01, 0x3b, 0x01].freeze
            DRIVER_MIRROR_UP              = [0x01, 0x3c, 0x01].freeze
            DRIVER_MIRROR_OUT             = [0x01, 0x3d, 0x01].freeze
            DRIVER_MIRROR_IN              = [0x01, 0x3e, 0x01].freeze

            MEMORY_SWITCH                 = [0x01, 0x44, 0x01].freeze

            # Unconfirmed!
            PASS_MIRROR_DOWN              = [0x02, 0x3b, 0x01].freeze
            PASS_MIRROR_UP                = [0x02, 0x3c, 0x01].freeze
            PASS_MIRROR_OUT               = [0x02, 0x3d, 0x01].freeze
            PASS_MIRROR_IN                = [0x02, 0x3e, 0x01].freeze

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
            # SOMETHING?                  = [0x05, 0x0a, 0x01].freeze
            # SOMETHING?                  = [0x05, 0x0b, 0x01].freeze
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
