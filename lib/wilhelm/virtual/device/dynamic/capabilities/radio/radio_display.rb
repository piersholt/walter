# frozen_string_literal: true

module Wilhelm
  class Virtual
    module Capabilities
      module Radio
        # CD Changer Reqests
        module CDChangerDisplay
          include Wilhelm::Virtual::API::Radio

          # rad  gfx  23  CA 20  "CD 1-01",
          # rad  gfx  23  CA 20  "CD 1-01",
          # rad  gfx  23  CA 20  "CD 1-01",
          # rad  gfx  23  CA 20  "CD 1-01",

          # def alt(mode = :scanning)
          #   case mode
          #   when :scanning
          #
          #   end
          # end

          STATION    = [70, 77, 32, 3, 49, 48, 53, 46, 57, 4, 32, 32, 32]
          STATION_ST = [70, 77, 32, 3, 49, 48, 53, 46, 57, 4, 32, 83, 84]

          def station(to: :gfx, chars: integer_array_to_chars(STATION))
            primary(to: to, gfx: 0x40, ike: 0x20, chars: chars)
          end

          def st(to: :gfx, chars: integer_array_to_chars(STATION_ST))
            primary(to: to, gfx: 0x50, ike: 0x20, chars: chars)
          end

          # def p(index)
          #   PRESETS[index]
          # end

          PRESETS = {
            # [32, 49, 5, 50, 42] (" 1☐2*")
            1 => " 1\x052*",
            # [50, 42, 5, 32, 51] ("2*☐ 3")
            2 => "2*\x05 3",
            # [50, 32, 5, 42, 51] ("2 ☐*3")
            3 => "2 \x05*3",
            # [32, 51, 5, 52, 42] (" 3☐4*")
            4 => " 3\x054*",
            # [52, 32, 5, 42, 53] ("4 ☐*5")
            5 => "4 \x05*5",
            # [32, 53, 5, 54, 42] (" 5☐6*")
            6 => " 5\x056*"
          }.freeze
          # [42, 49, 6, 5, 52, 32] ("*1☐☐4 ")
          # [50, 32, 5, 5, 52, 42] ("2 ☐☐4*")

          def preset(index = 1)
            list(m1: 0x41, m2: index, m3: 0x01, chars: PRESETS[index])
          end


          def preset!(index = 1, block = true)
            b = block ? 0x00 : 0x01
            secondary(gfx: 0x62, ike: b, zone: 0x42, chars: " P #{index} ")
            # Kernel.sleep(2)
            # secondary(gfx: 0x62, ike: 0x00, zone: 0x42, chars: " P #{index+1} ")
          end

          def channel!(index = 1, block = true)
            b = block ? 0x00 : 0x01
            secondary(gfx: 0x62, ike: b, zone: 0x01, chars: " FM#{index} ")
          end
        end
      end
    end
  end
end
