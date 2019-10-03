# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Default
            # Device::Telephone::Emulated::Default::Handler
            module Handler
              include Constants

              LOG_WARN_DEFAULT = '0x31 layout of 0x00, but not captured by Last Numbers or Directory!'.freeze

              # 0x00
              def handle_default(command)
                logger.debug(PROC) { "#handle_default(#{command})" }
                case command.function.value
                when FUNCTION_DEFAULT
                  branch(LAYOUT_DEFAULT, FUNCTION_DEFAULT, button_id(command.action))
                  raise(ArgumentError, LOG_WARN_DEFAULT)
                when FUNCTION_SOS
                  delegate_sos(command)
                else
                  unknown_function(command)
                end
              end
            end
          end
        end
      end
    end
  end
end
