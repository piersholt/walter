# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          module OnBoardComputer
            # OBC Interface Limit
            module Limit
              include API
              include Constants

              # Speed Limit 0x09 [On, Off]
              # @param Boolean enable
              def limit(enable = true)
                obc_bool(
                  field: FIELD_LIMIT,
                  control: enable ? CONTROL_ON : CONTROL_OFF
                )
              end

              # Limit 0x09 [Set as current ppeed]
              def limit!
                obc_bool(field: FIELD_LIMIT, control: CONTROL_CURRENT_SPEED)
              end

              # Limit 0x09 Request draw OBC
              def limit?
                obc_bool(field: FIELD_LIMIT, control: CONTROL_REQUEST)
              end

              alias l limit
              alias l! limit!
              alias l? limit?

              # Speed Limit 0x09 Value (mph vs. kmph?)
              def input_limit(speed)
                LOGGER.debug('GFX::OBC::Limit') { "#input_limit(#{speed})" }
                speed_byte_array = base_256_digits(speed)
                obc_var(field: FIELD_LIMIT, input: speed_byte_array)
              end

              private

              # @todo
              def valid_limit?; end
            end
          end
        end
      end
    end
  end
end
