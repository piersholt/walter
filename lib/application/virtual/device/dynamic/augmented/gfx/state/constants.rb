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
