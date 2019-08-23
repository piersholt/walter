# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          module Mock
            # Mock Info
            module Info
              include Constants

              MOD_PROG = 'Mock::Info'
              LIMIT_DIRECTORY = 8

              def info_service_open
                LOGGER.unknown(MOD_PROG) { '#info_service_open' }
                info!
                generate_info
              end

              def generate_info
                logger.unknown(PROC) { '#generate_info()' }
                rstrength
                rcall_costs_current
                rcall_cost_total
                rcall_time_minutes
                rcall_time_seconds
              end

              def rstrength(level = Random.rand(1..7))
                strength(bars(level))
              end

              def rcall_costs_current
                call_costs_current(rcurrent)
              end

              def rcall_cost_total
                call_cost_total(rtotal)
              end

              def rcall_time_minutes
                call_time_minutes(rmin)
              end

              def rcall_time_seconds
                call_time_seconds(rsec)
              end

              private

              # [0xb8, 0xb8, 0xb8, 0xb8, 0xb8, 0xb8, 0xb8]

              # 0 through 7 bars
              STRENGTHS = [
                0xb8, 0x5f, 0xb7, 0xb6, 0xb5, 0xb4, 0xb3, 0xb2
              ].freeze

              def bars(level)
                [STRENGTHS[level]] + Array.new(6) { 0x5a }
              end

              MASK_CURRENT = '%6.2f'
              MASK_TOTAL = '%7.2f'
              MASK_MIN = '%i'
              MASK_SEC = '%.2i'

              def rcurrent
                format(MASK_CURRENT, Random.rand(0..9))
              end

              def rtotal
                format(MASK_TOTAL, Random.rand(10..99))
              end

              def rmin
                format(MASK_MIN, Random.rand(0..59))
              end

              def rsec
                format(MASK_SEC, Random.rand(0..59))
              end
            end
          end
        end
      end
    end
  end
end
