# frozen_string_literal: true

class Virtual
  class AugmentedGFX < AugmentedDevice
    # Radio related command constants
    module State
      module Constants
        UNKNOWN = :unknown
        ON = :on
        OFF = :off

        GFX = :gfx

        ZERO = 0

        INPUT_TIMEOUT = 30

        CONFIRM_PRESS = 0x05
        CONFIRM_HOLD = 0x45
        CONFIRM_RELEASE = 0x85

        LEFT_1 = 0x01
        LEFT_2 = 0x02
        LEFT_3 = 0x03
        LEFT_4 = 0x04
        LEFT_5 = 0x05
        LEFT_6 = 0x06
        LEFT_7 = 0x07
        LEFT_8 = 0x08
        RIGHT_1 = 0x81
        RIGHT_2 = 0x82
        RIGHT_3 = 0x83
        RIGHT_4 = 0x84
        RIGHT_5 = 0x85
        RIGHT_6 = 0x86
        RIGHT_7 = 0x87
        RIGHT_8 = 0x88

        DATA_MODEL = {
          source: [:gfx, :tv],
          priority: [:gfx, :radio],
          monitor: [:on, :off],
          radio_overlay: [true, false],
          position: {
            main_menu: [
              :set,
              :obc,
              :dsp,
              tel: [
                :pin_code, :top_8, :directory, :dial, :info, :sos
              ]
            ]
          },
          radio_display: {
            header: [
              :service, :weather, :radio, :digital, :tape, :traffic, :cdc, :unknown
            ],
            body: {
              off: true,
              obc: true,
              menu: [:simple, :advanced],
              eq: [:show, :hide],
              select: [:show, :hide]
            }
          }
        }.freeze
      end
    end
  end
end
