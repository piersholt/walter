# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module ZKE
            module Activate
              # ZKE Activate Body Module
              module GM
                # 1. Doors
                CONTACT_DOOR_DRIVER_FRONT     = [0x00, 0x10, 0x01].freeze
                CONTACT_DOOR_PASS_FRONT       = [0x00, 0x11, 0x01].freeze
                CONTACT_DOOR_DRIVER_REAR      = [0x00, 0x12, 0x01].freeze
                CONTACT_DOOR_PASS_REAR        = [0x00, 0x13, 0x01].freeze

                # 2. Central Locking
                SWITCH_TAILGATE_INSIDE        = [0x00, 0x08, 0x01].freeze
                SWITCH_TAILGATE               = [0x00, 0x09, 0x01].freeze
                SWITCH_REAR_WINDOW            = [0x00, 0x07, 0x01].freeze
                CONTACT_TAILGATE              = [0x00, 0x0a, 0x01].freeze
                CONTACT_REAR_WINDOW           = [0x00, 0x1d, 0x01].freeze
                SWITCH_CENTRAL_LOCK           = [0x00, 0x0b, 0x01].freeze
                # SWITCH_TRUNK_LOCK
                # SWITCH_TRUNK_UNLOCK
                # MOTOR_TRUNK_UNLOCK
                RELAY_CENTRAL_LOCK            = [0x00, 0x41, 0x01].freeze
                RELAY_CENTRAL_UNLOCK          = [0x00, 0x42, 0x01].freeze
                RELAY_CENTRAL_SECURE          = [0x00, 0x42, 0x01].freeze
                # RELAY_UNLOCK_TRUNK
                # RELAY_UNLOCK_REAR_WINDOW

                # 3.  Windows
                SWITCH_WINDOW_DRIVER_OPEN       = [0x00, 0x00, 0x01].freeze
                SWITCH_WINDOW_DRIVER_CLOSE      = [0x00, 0x01, 0x01].freeze
                SWITCH_WINDOW_PASS_OPEN         = [0x00, 0x03, 0x01].freeze
                SWITCH_WINDOW_PASS_CLOSE        = [0x00, 0x04, 0x01].freeze
                RELAY_WINDOW_DRIVER_REAR_CLOSE  = [0x00, 0x44, 0x01].freeze
                RELAY_WINDOW_DRIVER_REAR_OPEN   = [0x00, 0x45, 0x01].freeze
                RELAY_WINDOW_PASS_REAR_CLOSE    = [0x00, 0x46, 0x01].freeze
                RELAY_WINDOW_PASS_REAR_OPEN     = [0x00, 0x47, 0x01].freeze

                # 4. Cleaning
                RESET_CONTACT_WIPER           = [0x00, 0x06, 0x01].freeze
                SWITCH_WIPER_1                = [0x00, 0x14, 0x01].freeze
                SWITCH_WIPER_2                = [0x00, 0x15, 0x01].freeze
                SWITCH_WASHER_NORMAL          = [0x00, 0x16, 0x01].freeze
                SWITCH_WASHER_INTENSIVE       = [0x00, 0x02, 0x01].freeze
                RELAY_WIPERS_STAGE_1          = [0x00, 0x38, 0x01].freeze
                RELAY_WIPERS_STAGE_2          = [0x00, 0x39, 0x01].freeze
                RELAY_WASHER_NORMAL_PUMP      = [0x00, 0x4b, 0x01].freeze
                RELAY_WASHER_INTENSIVE_PUMP   = [0x00, 0x3b, 0x01].freeze
                RELAY_HEADLIGHT_WASH_PUMP     = [0x00, 0x3a, 0x01].freeze

                # 5. Antitheft
                CONTACT_BONNET                = [0x00, 0x18, 0x01].freeze
                CONTACT_GLOVE_BOX             = [0x00, 0x1a, 0x01].freeze
                # INTERIOR_PROTECTION
                # WINDOW_SURVEILANCE_DRIVER_REAR
                # WINDOW_SURVEILANCE_PASS_REAR
                # INPUT_TILT_ALARM_SENSOR
                DWA_LED                       = [0x00, 0x3c, 0x01].freeze
                # OUTPUT_TILT_ALARM_SENSOR
                STARTER_ENABLE                = [0x00, 0x3e, 0x01].freeze
                # HORN_ANTI_THEFT
                IMMOBILIZER                   = [0x00, 0x51, 0x01].freeze

                # 6. Clamps
                TERMINAL_R                    = [0x00, 0xa8, 0x01].freeze
                TERMINAL_15                   = [0x00, 0xa9, 0x01].freeze
                TERMINAL_50                   = [0x00, 0xaA, 0x01].freeze
                TERMINAL_58                   = [0x00, 0xc1, 0x01].freeze

                # 7. Else
                SWITCH_INTERIOR_LIGHTS        = [0x00, 0x17, 0x01].freeze
                CONSUMER_SHUTDOWN             = [0x00, 0x50, 0x01].freeze

                # -------------------------------------------------------------

                # NFI? Type = PS
                ZV_SWITCH_PACKAGE_FT_LOCK     = [0x00, 0x88, 0x01].freeze
                ZV_SWITCH_PACKAGE_BT_LOCK     = [0x00, 0x98, 0x01].freeze
                LOCKING_FBZV_KS               = [0x00, 0xb1, 0x01].freeze

                # NOTE: there's probably a motor activate too
                def rear_window_unlock
                  activate(SWITCH_REAR_WINDOW)
                end
              end
            end
          end
        end
      end
    end
  end
end
