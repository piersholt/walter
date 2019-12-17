# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module Analogue
            # Radio::Capabilities::Analogue::Constants
            module Constants
              include Capabilities::Constants

              # 0x21

              # :layout
              ANALOGUE_PRESET   = 0b0_0001 << 0 # 0x41
              ANALOGUE_RDS      = 0b0_0011 << 0 # 0x43

              # :m2
              BAND = {
                fma:  0b000 << 5,
                fm1:  0b001 << 5,
                fm2:  0b010 << 5,
                mw:   0b011 << 5,
                lw:   0b100 << 5,
                sw:   0b101 << 5,
                ama:  0b110 << 5,
                am:   0b111 << 5
              }.freeze

              # Layout 0x41 only!
              PRESET = {
                1 =>      0b0_0001,
                2 =>      0b0_0010,
                3 =>      0b0_0011,
                4 =>      0b0_0100,
                5 =>      0b0_0101,
                6 =>      0b0_0110
              }.freeze

              # Layout 0x43 only!
              RDS = {
                rds:      0b0_0010,
                tp:       0b0_0100,
                tp_blink: 0b0_1000
              }.freeze

              # :m3
              INDEX_BAND_PRESETS  = 0x00
              INDEX_PRESETS       = 0x00 # 0x41
              INDEX_RDS           = 0x06 # 0x43

              # 0x23

              # :gt
              # Field 'C"
              ANALOGUE_MANUAL   = 0b001 << 0
              ANALOGUE_SCAN     = 0b010 << 0
              ANALOGUE_II       = 0b011 << 0
              ANALOGUE_I        = 0b100 << 0
              ANALOGUE_T        = 0b110 << 0
              ANALOGUE_TP       = 0b111 << 0

              # Field 'D'
              ANALOGUE_T_ALT    = 0b01 << 3
              ANALOGUE_STEREO   = 0b10 << 3
              ANALOGUE_ST       = 0b10 << 3

              # :chars
              ANALOGUE_MSG_PRES_OFF = 'PRES OFF'      # 0x40
              ANALOGUE_MSG_PRES_ON  = 'PRES ON '      # 0x40
              ANALOGUE_MSG_AUTO     = ' AUTOSTORE'    # 0x40

              ANALOGUE_MSG_STATION  = " FM \x03 91.5\x04   " # 0x40
              ANALOGUE_MSG_ST       = " FM \x03 91.5\x04 ST" # 0x50
              # ANALOGUE_MSG_STATION  = " FM \x03105.9\x04   " # 0x40
              # ANALOGUE_MSG_ST       = " FM \x03105.9\x04 ST" # 0x50
            end
          end
        end
      end
    end
  end
end
