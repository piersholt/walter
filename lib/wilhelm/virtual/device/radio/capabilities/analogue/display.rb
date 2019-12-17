# frozen_string_literal: true

require_relative 'display/rds'
require_relative 'display/preset'
require_relative 'display/select'

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module Analogue
            # Analogue Radio Display
            module Display
              include API
              include Constants

              include RDS
              include Preset
              include Select

              # 0x40 0b0100_0000
              def station(
                to: :gt,
                chars: ANALOGUE_MSG_STATION
              )
                draw_23(
                  to: to,
                  gt: SOURCE_ANALOGUE,
                  ike: 0x20,
                  chars: chars
                )
              end

              # 0x50 0b0101_0000
              def st(
                to: :gt,
                chars: ANALOGUE_MSG_ST
              )
                draw_23(
                  to: to,
                  gt: SOURCE_ANALOGUE | ANALOGUE_ST,
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
