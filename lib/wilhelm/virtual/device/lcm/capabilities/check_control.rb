# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        module Capabilities
          # LCM::Capabilities::CheckControl
          module CheckControl
            include Helpers::Data
            include Constants

            def check(
              byte1,
              byte2,
              chars = generate_chars(5..20)
            )
              ccm(b1: byte1, b2: byte2, chars: chars)
            end

            def check_chars(nap = 3)
              char_set = (0x00..0xff).to_a
              until char_set.empty? do
                char_array = char_set.slice!(0, 20)
                char_array.fill(0x20, char_array.size, 4) if char_array.size < 20
                check(0x37, 0x00, char_array)
                sleep(nap)
              end
            end

            def cc_ok
              check(
                CHEVRON | GONG | DISPLAY_Y | DISPLAY_UPDATE,
                GONG_NONE | CHEV_OFF,
                MSG_OK.bytes
              )
            end

            def cc_recall
              check(
                RECALL,
                GONG_NONE | CHEV_OFF,
                MSG_ALL.shuffle.first.bytes
              )
            end

            def cc_persist
              check(
                0x30,
                GONG_NONE | CHEV_ON,
                MSG_NIL.bytes
              )
            end

            def cc_clear
              check(
                CHEVRON | GONG | DISPLAY_OFF,
                GONG_NONE | CHEV_OFF,
                MSG_NIL.bytes
              )
            end

            # MSG_ALL.shuffle.first.bytes
            # generate_chars(1..20, 65..90)
            def cc(
              arg1 = CHEVRON | GONG,
              arg2 = GONG_NONE | CHEV_OFF,
              chars = generate_chars(21..21, 65..90)
            )
              check(
                arg1,
                arg2,
                chars
              )
            end
          end
        end
      end
    end
  end
end
