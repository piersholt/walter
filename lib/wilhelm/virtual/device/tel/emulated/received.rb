# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::Received
          module Received
            include Constants

            # 0x02 PONG
            # Piggyback off the radio announce to annunce
            def handle_announce(message)
              # logger.warn('SimulatedTEL') { "handling pong: #{message.from}" }
              # logger.warn('SimulatedTEL') { "message.from?(:rad) => #{message.from?(:rad)}" }

              return false unless message.from?(:gfx)
              return false unless message.command.status.value == ANNOUNCE
              logger.info(PROC) { "GFX has announced. Piggybacking (sic)" }
              ready
              true
            end

            # 0x20 TEL-OPEN
            def handle_tel_open(message)
              logger.debug(PROC) { "Mock: handling telephone tel open request..." }
              open_dial
              # draw_21(layout: LAYOUT_DIAL, m2: M2_DEFAULT, m3: 0x00, chars: [])
            end

            # 0x22 CACHE
            def handle_gfx_status(message)
              logger.debug(PROC) { "Mock: handling GFX status..." }
              if message.command.status.value == STATUS_CLEAR
                logger.debug(PROC) { "Mock: GFX status clear!" }
                release_pending_render
              elsif message.command.status.value == STATUS_SUCCESS
                logger.debug(PROC) { "Mock: GFX status success!" }
                clear_retry
              elsif message.command.status.value == STATUS_HOME_SUCCESS
                logger.debug(PROC) { "Mock: GFX menu status success!" }
                clear_retry
              elsif message.command.status.value == STATUS_ERROR
                logger.debug(PROC) { "Mock: GFX status error!" }
                release_pending_retry
              end
            end

            # 0x31 DATA
            def handle_data_request(command)
              return false unless command.action.parameters[:button_state].value == 0b00
              logger.unknown(PROC) { '#handle_data_request(command)' }

              case command.source.value
              when SOURCE_RECENT
                false
              when SOURCE_INFO
                false
              when SOURCE_DIAL
                if [FUNCTION_SOS, FUNCTION_NAVIGATE].include?(command.function.value)
                  dial_clear
                end
              when SOURCE_DIRECTORY
                if [FUNCTION_SOS, FUNCTION_NAVIGATE].include?(command.function.value)
                  directory_clear
                end
              when SOURCE_TOP_8
                if [FUNCTION_SOS, FUNCTION_NAVIGATE].include?(command.function.value)
                  top_8_clear
                end
              end

              # @todo use source to work out when to clear

              case command.function.value
              when FUNCTION_RECENT
                # delegate_contact
              when FUNCTION_CONTACT
                delegate_contact(command.source, command.action)
              when FUNCTION_DIAL
                delegate_dial(command.action)
              when FUNCTION_SOS
                delegate_sos
              when FUNCTION_NAVIGATE
                delegate_navigation(command.action)
              when FUNCTION_INFO
                delegate_function_info
              end
            end

            private

            def button_id(action)
              action.parameters[:button_id].value
            end

            def delegate_contact(source, action)
              logger.unknown(PROC) { "#delegate_contact(#{action})" }
              index = button_id(action)
              logger.unknown(PROC) { FUNCTIONS[FUNCTION_CONTACT][index] }

              case source.value
              when SOURCE_DIRECTORY
                directory_name('Dir. Contact.')
              when SOURCE_TOP_8
                top_8_name('Top 8. Contact.')
              end
            end

            def delegate_dial(action)
              logger.unknown(PROC) { "#delegate_dial(#{action})" }
              index = button_id(action)
              logger.unknown(PROC) { FUNCTIONS[FUNCTION_DIAL][index] }
              return dial_number_remove if index == ACTION_REMOVE
              dial_number(FUNCTIONS[FUNCTION_DIAL][index])
            end

            def delegate_sos
              logger.unknown(PROC) { "#delegate_sos" }
              logger.unknown(PROC) { FUNCTIONS[FUNCTION_SOS][ACTION_SOS_OPEN] }
              draw_23(gfx: 0xc0, ike: 0x20, chars: 'SOS: 112!')
            end

            def delegate_navigation(action)
              logger.unknown(PROC) { "#delegate_navigation(#{action})" }
              index = button_id(action)
              case index
              when ACTION_DIAL_OPEN
                logger.unknown(PROC) { FUNCTIONS[FUNCTION_NAVIGATE][ACTION_DIAL_OPEN] }
                open_dial
              when ACTION_SMS_OPEN
                logger.unknown(PROC) { FUNCTIONS[FUNCTION_NAVIGATE][ACTION_SMS_OPEN] }
              when ACTION_DIR_OPEN
                logger.unknown(PROC) { FUNCTIONS[FUNCTION_NAVIGATE][ACTION_DIR_OPEN] }
                generate_directory
              else
              end
            end

            def delegate_function_info
              logger.unknown(PROC) { "#delegate_function_info" }
              logger.unknown(PROC) { FUNCTIONS[FUNCTION_INFO][ACTION_INFO_OPEN] }
              open_info
            end

            # @deprecated
            def ready
              logger.warn(PROC) { '#ready is deprecated!' }
              logger.debug(PROC) { 'Telephone ready macro!' }
              leds(:off)
              leds!
              power!(OFF)
              status!
              announce
              sleep(0.25)
              power!(ON)
              status!
              # tel_led(LED_ALL)
              # bluetooth_pending
            end

            # @deprecated
            def tel_state(telephone_state = TEL_OFF)
              logger.warn(PROC) { '#tel_state is deprecated!' }
              status(status: telephone_state)
            end
          end
        end
      end
    end
  end
end
