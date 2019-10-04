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
                sos!
              end
            end

            # Function: 0x07
            def delegate_navigation(command)
              logger.debug(PROC) { "#delegate_navigation(#{command.layout.ugly}, #{command.pretty})" }
              case button_id(command.action)
              when ACTION_OPEN_DIAL
                branch(command.layout.value, FUNCTION_NAVIGATE, ACTION_OPEN_DIAL)
                dial_open
                dial!
              when ACTION_OPEN_SMS
                branch(command.layout.value, FUNCTION_NAVIGATE, ACTION_OPEN_SMS)
                sms_open
                sms_index!
              when ACTION_OPEN_DIR
                branch(command.layout.value, FUNCTION_NAVIGATE, ACTION_OPEN_DIR)
                directory_open
                directory!
              end
            end

            # Function: 0x08
            def delegate_info(command)
              logger.debug(PROC) { "#delegate_info(#{command.layout.ugly}, #{command.pretty})" }
              case command.action.value
              when ACTION_OPEN_INFO
                branch(command.layout.value, FUNCTION_INFO, ACTION_OPEN_INFO)
                info_open
                info!
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
