# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module Analogue
            module Display
              # Analogue::Display::Select
              module Select
                include API
                include Constants

                # [m]     Mode: Manual
                # [SCAN]  Mode: SCAN
                # [II]    Mode: Search (Sensitive)
                # [I]     Mode: Search (Non Sensitive)
                # [T]     Traffic Reports
                # [TP]    Traffic Program

                def manual(
                  chars: integer_array_to_chars(ANALOGUE_MSG_STATION)
                )
                  draw_23(
                    to: :gt,
                    gt: SOURCE_ANALOGUE | ANALOGUE_MANUAL,
                    ike: 0x20,
                    chars: chars
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
