# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Telematics
            # Device::Telephone::Emulated::Telematics::Handler
            module Handler
              include Constants

              # Function: 0x05
              def delegate_sos(command)
                logger.debug(PROC) { "#delegate_sos(#{command})" }
                case button_id(command.action)
                when ACTION_SOS_OPEN
                  sos!
                  branch(command.layout.value, FUNCTION_SOS, ACTION_SOS_OPEN)
                  telematics_open
                end
              end

              # 0xf1
              def handle_telematics(command)
                logger.debug(PROC) { "#handle_telematics(#{command})" }
                case command.function.value
                when FUNCTION_NAVIGATE
                  case button_id(command.action)
                  when ACTION_TELEMATICS_BACK
                    branch(command.layout.value, FUNCTION_NAVIGATE, ACTION_TELEMATICS_BACK)
                    dial!
                    dial_open
                  end
                when FUNCTION_TELEMATICS
                  telematics!
                  branch(command.layout.value, FUNCTION_TELEMATICS, button_id(command.action))
                end
              end

              # 0xA2 COORD
              def handle_telematics_coord(command)
                logger.debug(PROC) { '#handle_telematics_coord' }
                telematics_signal(command)
                telematics_coordinates(command.coordinates.to_h)
              end

              # 0xA4 ADDR
              def handle_telematics_addr(command)
                logger.debug(PROC) { '#handle_telematics_addr' }
                case command.b.ugly
                when :city
                  telematics_city(command.chars.chars.to_s)
                when :street
                  telematics_street(command.chars.chars.to_s)
                end
              end
            end
          end
        end
      end
    end
  end
end
