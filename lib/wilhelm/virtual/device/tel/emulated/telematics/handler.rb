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
                  branch(command.layout.value, FUNCTION_SOS, ACTION_SOS_OPEN)
                  sos!
                  telematics_open
                end
              end

              # 0xf1
              def handle_telematics(command)
                logger.debug(PROC) { "#handle_telematics(#{command})" }
                sos!
                case command.function.value
                when FUNCTION_BACK | FUNCTION_TELE
                  dial_open
                when FUNCTION_BACK | FUNCTION_SMS
                  logger.warn(PROC) { "Stale layout cache! Expected ID: 0x#{(FUNCTION_BACK | FUNCTION_TELE).to_s(16)}. Actual ID: 0x#{command.function.value.to_s(16)}" }
                  dial_open
                when FUNCTION_TELE
                  logger.unknown(PROC) { 'FUNCTION_TELE' }
                when FUNCTION_SMS
                  logger.warn(PROC) { "Stale layout cache! Expected ID: 0x#{(FUNCTION_TELE).to_s(16)}. Actual ID: 0x#{command.function.value.to_s(16)}" }
                  logger.unknown(PROC) { 'FUNCTION_TELE' }
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
