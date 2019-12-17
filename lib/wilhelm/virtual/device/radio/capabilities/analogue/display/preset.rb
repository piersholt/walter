# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module Analogue
            module Display
              # Analogue::Display::Preset
              # 0x41
              module Preset
                include API
                include Constants

                # note 0x06...
                # [0x2a, 0x31, 0x06, 0x05, 0x34, 0x20] ("*1☐☐4 ")
                # [0x32, 0x20, 0x05, 0x05, 0x34, 0x2a] ("2 ☐☐4*")
                # [32, 49, 5, 50, 42] (" 1☐2*")
                # [50, 42, 5, 32, 51] ("2*☐ 3")
                # [50, 32, 5, 42, 51] ("2 ☐*3")
                # [32, 51, 5, 52, 42] (" 3☐4*")
                # [52, 32, 5, 42, 53] ("4 ☐*5")
                # [32, 53, 5, 54, 42] (" 5☐6*")

                # @note this should reflect band, i.e. FM1 = "*A1" FM2 = "*7"
                PRESET_0 = " 1\x052 \x05 3\x054 \x05 5\x056 "
                PRESET_1 = "*1\x052 \x05 3\x054 \x05 5\x056 "
                PRESET_2 = " 1\x052*\x05 3\x054 \x05 5\x056 "
                PRESET_3 = " 1\x052 \x05*3\x054 \x05 5\x056 "
                PRESET_4 = " 1\x052 \x05 3\x054*\x05 5\x056 "
                PRESET_5 = " 1\x052 \x05 3\x054 \x05*5\x056 "
                PRESET_6 = " 1\x052 \x05 3\x054 \x05 5\x056*"

                PRESETS = {
                  0 => PRESET_0,
                  1 => PRESET_1,
                  2 => PRESET_2,
                  3 => PRESET_3,
                  4 => PRESET_4,
                  5 => PRESET_5,
                  6 => PRESET_6
                }.freeze

                def preset(id = 0)
                  draw_21(
                    layout: SOURCE_ANALOGUE | ANALOGUE_PRESET,
                    m2: PRESET.fetch(id, PRESET[0]),
                    m3: INDEX_PRESETS,
                    chars: PRESETS.fetch(id, PRESETS[0])
                  )
                end
              end
            end
          end
        end
      end
    end
  end
end
