# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module Body
            module Memory
              module Presets
                PRESET_ONE   = '01 08 01'
                # GM3   	GLO-L 	78        	01
                PRESET_TWO   = '01 09 01'
                # GM3   	GLO-L 	78        	02
                PRESET_THREE = '01 0A 01'
                SAVE_PRESENT = '01 44 01'

                # GM3   	GLO-L 	78        	00
              end

              # 0x72 = GM5?
              # module NotGM
              #   module Memory
              #     # Driver Seat: Move to Memory Position 2
              #     LEFT_SLOT_2 = '3F 06 72 0C 02 02 00 CK'
              #     # Driver Seat: Move to Memory Position 3
              #     LEFT_SLOT_3 = ￼￼￼￼￼￼'3F 06 72 0C 02 04 00 CK'
              #   end
              # end

              module Mirrors
                X_FOLD_OUT = '01 30 01'
                X_FOLD_IN  = '01 31 01'
                # X_DOWN     = '01 3B 01'
                # X_UP       = '01 3C 01'
                # X_OUT      = '01 3D 01'
                # X_IN       = '01 3E 01'

                LEFT_FOLD_OUT = '02 30 01'
                LEFT_FOLD_IN  = '02 31 01'
                # LEFT_DOWN     = '02 3B 01'
                # LEFT_UP       = '02 3C 01'
                # LEFT_IN       = '02 3D 01'
                # LEFT_OUT      = '02 3E 01'
              end

              # module VehicleControl
              #   module Mirrors
              #     # STOP         = '9B 04 51 6D 40 CK'
              #     SELECT_RIGHT = '9B 04 51 6D 40 E3'
              #     SELECT_LEFT  = '9B 04 51 6D 80 23'
              #     OUT          = '9B 04 51 6D 41 CK'
              #     IN           = '9B 04 51 6D 42 CK'
              #     UP           = '9B 04 51 6D 44 CK'
              #     DOWN         = '9B 04 51 6D 48 CK'
              #   end
              # end

              module Seats
                # all good
                FORWARD      = [0x05, 0x00, 0x01]
                BACKWARD     = [0x05, 0x01, 0x01]
                UP           = '05 02 01'
                DOWN         = '05 03 01'
                TILT_BACK    = '05 04 01'
                TILT_FORWARD = '05 05 01'
                BACK_FORWARD = '05 06 01'
                BACK_BACK    = '05 07 01'
                # 08 = headrest up
                # 09 = headrest down

                def seat_forward
                  api_vehicle_control(to: :gm, arguments: array(FORWARD))
                end

                def seat_backward
                  api_vehicle_control(to: :gm, arguments: array(BACKWARD))
                end
              end

              module Wheel
                # all good
                IN   = '05 10 01'
                OUT  = '05 11 01'
                UP   = '05 0E 01'
                DOWN = '05 0F 01'
              end
            end
          end
        end
      end
    end
  end
end
