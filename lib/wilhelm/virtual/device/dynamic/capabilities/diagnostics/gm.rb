module Wilhelm
  module Virtual
    module Capabilities
      module Diagnostics
        module CentralLocking
          HATCH_OPEN     = '00 0A 01'
          TRUNK_OPEN_REMOTE = '00 08 01'


          # HATCH_OPEN        = '00 07 01'
          TRUNK_OPEN        = '00 09 01'
          
          TRUNK_CONTACT     = '00 0A 01'
          HATCH_CONTACT     = '00 1D 01'

          # This is a state switch
          CENTRAL_LOCK      = '00 0B 01'

          # Lock 3	DIS Unknown 	General news 1
          # Lock Driver	DIS Unknown 	General news 1
          # Trunc Open	DIS Unknown 	General news 1

          LOCK_DRIVER = '47 01' # no
          LOCK_MINOR  = '4F 01' # no
          # TRUNK_OPEN  = '02 01'

          UNLOCK_ALL = '96 01' # no
          LOCK_ALL =  '97 01' # no
        end

        module Doors
          # all work
          FRONT_RIGHT_CONTACT = '00 10 01'
          FRONT_LEFT_CONTACT  = '00 11 01'
          REAR_RIGHT_CONTACT  = '00 12 01'
          REAR_LEFT_CONTACT   = '00 13 01'
        end


        module Windows
          FRONT_RIGHT_OPEN  = '00 00 01'
          FRONT_RIGHT_CLOSE = '00 01 01'

          FRONT_LEFT_OPEN   = '00 03 01'
          FRONT_LEFT_CLOSE  = '00 04 01' # this is making rear left close...?

          REAR_RIGHT_CLOSE  = '00 44 01'
          REAR_RIGHT_OPEN   = '00 45 01'

          REAR_LEFT_CLOSE   = '00 46 01' # Good
          REAR_LEFT_OPEN    = '00 47 01' # Good

          SIGNAL_LIGHTS_ON = '00 63 01'

          REAR_OPEN = '00 64 01' # good
          FRONT_OPEN = '00 65 01' # good

          SUNROOF_OPEN = '00 66'

          # SUNROOF_OPEN  = '7E 01'
          SUNROOF_CLOSE = '7F 01'

          def window_fr_down
            vehicle_control(to: :gm3, arguments: integers_input(0x00, 0x00, 0x01))
          end

          def window_fr_up
            vehicle_control(to: :gm3, arguments: integers_input(0x00, 0x01, 0x01))
          end

          def window_fl_down
            vehicle_control(to: :gm3, arguments: integers_input(0x00, 0x03, 0x01))
          end

          def window_fl_up
            vehicle_control(to: :gm3, arguments: integers_input(0x00, 0x04, 0x01))
          end
        end

        module Windscreen
          CLEAN = '00 02 01'
          # WIPER = '49 01' - doesn't work
          # FLUID = '62 01' - don't work
        end


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

        module Memory
          PRESET_ONE   = '01 08 01'
          # GM3   	GLO-L 	78        	01
          PRESET_TWO   = '01 09 01'
          # GM3   	GLO-L 	78        	02
          PRESET_THREE = '01 0A 01'
          SAVE_PRESENT = '01 44 01'

          # GM3   	GLO-L 	78        	00
        end

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
            vehicle_control(to: :gm3, arguments: array(FORWARD))
          end

          def seat_backward
            vehicle_control(to: :gm3, arguments: array(BACKWARD))
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

    # module NotGM
    #   module Memory
    #     # Driver Seat: Move to Memory Position 2
    #     LEFT_SLOT_2 = '3F 06 72 0C 02 02 00 CK'
    #     # Driver Seat: Move to Memory Position 3
    #     LEFT_SLOT_3 = ￼￼￼￼￼￼'3F 06 72 0C 02 04 00 CK'
    #   end
    # end

    # BMBT --> LKM : Light dimmer status request
    # // To NAV locat F0 03 D0 5D 7E
    #
    # GT --> BMBT: RGB control: LCD_off TV
    # // off 3B 05 F0 4F 01 01 81
    # GT --> BMBT: RGB control: LCD_on TV
    # // on 3B 05 F0 4F 11 11 81
    #
    # [ID:T URN_LIGHT S_OFF] 00 04 BF 76 00 cc
    # [ID:FLASH_WARN] 00 04 bf 76 02 cc
    # [ID:FLASH_LOW] 00 04 bf 76 04 cc
    # [ID:FLASH_LOW_WARN] 00 04 bf 76 06 cc
    # [ID:FLASH_HI] 00 04 bf 76 08 cc
    # [ID:FLASH_HI_WARN] 00 04 bf 76 0A cc
    # [ID:FLASH_LOW_HI] 00 04 bf 76 0C
    # [ID:FLASH_LOW_HI_WARN] 00 04 bf 76 0E cc
    # [ID:FLASH_LOW_SMALL] 80 04 BF 11 03 cc
    # [ID:FLASH_T EST 1] 00 04 bf 76 11 cc


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


    # 3F 06 00 0C 00 0B 01 3F
    # 3F 06 00 0C 00 07 01 33
    # 3F 06 00 0C 00 04 01 30
    # 3F 06 00 0C 00 47 01 73
    # 3F 06 00 0C 00 46 01 72
    # 3F 06 00 0C 00 45 01 71
    # 3F 06 00 0C 00 44 01 70
    # 3F 06 00 0C 00 03 01 37
    # 3F 06 00 0C 00 45 01 71
    # 3F 06 00 0C 00 44 01 70
    # 3F 06 00 0C 00 47 01 73
    # 3F 06 00 0C 00 46 01 72
    # 3F 06 00 0C 00 03 01 37
    # 3F 06 00 0C 00 04 01 30
    # 3F 06 00 0C 00 00 01 34
    # 3F 06 00 0C 00 01 01 35
    # 3F 06 00 0C 00 10 01 24
    # 3F 06 00 0C 00 10 01 24
    # 3F 06 00 0C 00 10 01 24
    # 3F 06 00 0C 00 11 01 25
    # 3F 06 00 0C 00 12 01 26
    # 3F 06 00 0C 00 13 01 27
    # 3F 06 00 0C 00 0A 01 3E
    # 3F 06 00 0C 00 1D 01 29
    # 3F 06 00 0C 00 07 01 33
    # 3F 06 00 0C 00 09 01 3D
    # 3F 06 00 0C 00 08 01 3C
    # 3F 06 00 0C 00 0A 01 3E
    # 3F 06 00 0C 00 1D 01 29
  end
end
