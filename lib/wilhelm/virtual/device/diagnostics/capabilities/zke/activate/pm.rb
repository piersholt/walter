# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module ZKE
            module Activate
              # Diagnostics::Capabilities::GM::Activate::PM
              module PM
                # Seat
                SEAT_FORWARD                  = [0x05, 0x00, 0x01].freeze
                SEAT_BACK                     = [0x05, 0x01, 0x01].freeze

                SEAT_UP                       = [0x05, 0x02, 0x01].freeze
                SEAT_DOWN                     = [0x05, 0x03, 0x01].freeze

                SEAT_TILT_BACK                = [0x05, 0x04, 0x01].freeze
                SEAT_TILT_FORWARD             = [0x05, 0x05, 0x01].freeze

                SEAT_THIGH_BACK               = [0x05, 0x0a, 0x01].freeze
                SEAT_THIGH_FORWARD            = [0x05, 0x0b, 0x01].freeze

                # Backrest
                SEAT_BACKREST_BACK            = [0x05, 0x06, 0x01].freeze
                SEAT_BACKREST_FORWARD         = [0x05, 0x07, 0x01].freeze

                SEAT_HEADREST_UP              = [0x05, 0x08, 0x01].freeze
                SEAT_HEADREST_DOWN            = [0x05, 0x09, 0x01].freeze

                SEAT_SHOULDER_BACK            = [0x05, 0x0c, 0x01].freeze
                SEAT_SHOULDER_FORWARD         = [0x05, 0x0d, 0x01].freeze

                # Steering Column
                STEERING_COLUMN_UP            = [0x05, 0x0e, 0x01].freeze
                STEERING_COLUMN_DOWN          = [0x05, 0x0f, 0x01].freeze

                STEERING_COLUMN_IN            = [0x05, 0x10, 0x01].freeze
                STEERING_COLUMN_OUT           = [0x05, 0x11, 0x01].freeze
              end
            end
          end
        end
      end
    end
  end
end
