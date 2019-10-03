# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone::Capabilities::Common
          # Common function delegates to avoid cluttering feature handlers
          module Common
            include Constants

            # Function: 0x05
            def delegate_sos(command)
              logger.debug(PROC) { "#delegate_sos(#{command})" }
              case button_id(command.action)
              when ACTION_SOS_OPEN
                branch(command.layout.value, FUNCTION_SOS, ACTION_SOS_OPEN)
                sos_open
              end
            end

            # Function: 0x07
            def delegate_navigation(command)
              logger.debug(PROC) { "#delegate_navigation(#{command.layout.ugly}, #{command.pretty})" }
              case button_id(command.action)
              when ACTION_OPEN_DIAL
                branch(command.layout.value, FUNCTION_NAVIGATE, ACTION_OPEN_DIAL)
                dial!
                dial_open
              when ACTION_OPEN_SMS
                branch(command.layout.value, FUNCTION_NAVIGATE, ACTION_OPEN_SMS)
                sms_index!
                sms_open
              when ACTION_OPEN_DIR
                branch(command.layout.value, FUNCTION_NAVIGATE, ACTION_OPEN_DIR)
                directory!
                directory_open
              end
            end

            # Function: 0x08
            def delegate_info(command)
              logger.debug(PROC) { "#delegate_info(#{command.layout.ugly}, #{command.pretty})" }
              case command.action.value
              when ACTION_OPEN_INFO
                info!
                branch(command.layout.value, FUNCTION_INFO, ACTION_OPEN_INFO)
                info_service_open
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
