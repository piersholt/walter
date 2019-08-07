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
            def handle_pong(message)
              return false unless message.from?(:gfx)
              return false unless message.command.status.value == ANNOUNCE
              logger.info(PROC) { "GFX has announced. Piggybacking (sic)" }
              ready
              true
            end

            # 0x20 TEL-OPEN
            def handle_tel_open(*)
              logger.debug(PROC) { '#handle_tel_open' }
              generate_top_8
            end

            # 0x31 INPUT
            def handle_input(command)
              # @note filter HOLD and RELEASE
              return false unless press?(command)
              logger.debug(PROC) { '#handle_input(command)' }

              case command.layout.value
              when LAYOUT_DEFAULT
                false
              when LAYOUT_INFO
                false
              when LAYOUT_DIAL
                if [FUNCTION_SOS, FUNCTION_NAVIGATE].include?(command.function.value)
                  dial_clear
                end
              when LAYOUT_DIRECTORY
                if [FUNCTION_SOS, FUNCTION_NAVIGATE].include?(command.function.value)
                  directory_clear
                end
              when LAYOUT_TOP_8
                if [FUNCTION_SOS, FUNCTION_NAVIGATE].include?(command.function.value)
                  top_8_clear
                end
              end

              # @todo use layout to work out when to clear

              case command.function.value
              when FUNCTION_DEFAULT
                delegate_default(command.layout, command.button)
              when FUNCTION_CONTACT
                delegate_contact(command.layout, command.button)
              when FUNCTION_DIGIT
                delegate_digit(command.layout, command.button)
              when FUNCTION_SOS
                delegate_sos(command.layout)
              when FUNCTION_NAVIGATE
                delegate_navigation(command.layout, command.button)
              when FUNCTION_INFO
                delegate_info(command.layout)
              else
                logger.warn(PROC) { "Unrecognised function! #{command.function}" }
              end
            end

            private

            def button_id(button)
              button.parameters[:id].value
            end

            def button_state(button)
              button.parameters[:state].value
            end

            def layout_id(layout)
              layout.value
            end

            def press?(command)
              button_state(command.button) == INPUT_PRESS
            end

            def delegate_default(layout, button)
              logger.unknown(PROC) { "#delegate_default(#{layout}, #{button})" }
              index = button_id(button)
              logger.unknown(PROC) { INPUT_MAP[layout.value][FUNCTION_DEFAULT][index] }

              case layout.value
              when LAYOUT_DEFAULT
                case index
                when RECENT_BACK
                  logger.unknown(PROC) { INPUT_MAP[LAYOUT_DEFAULT][FUNCTION_DEFAULT][RECENT_BACK] }
                when RECENT_FORWARD
                  logger.unknown(PROC) { INPUT_MAP[LAYOUT_DEFAULT][FUNCTION_DEFAULT][RECENT_FORWARD] }
                end
              when LAYOUT_SMS_INDEX
                case index
                when (ACTION_SMS_1..ACTION_SMS_10)
                  logger.unknown(PROC) { INPUT_MAP[LAYOUT_DEFAULT][FUNCTION_DEFAULT][index] }
                  generate_sms_show
                when ACTION_SMS_11
                  logger.unknown(PROC) { INPUT_MAP[LAYOUT_DEFAULT][FUNCTION_DEFAULT][ACTION_SMS_11] }
                when ACTION_SMS_BACK
                  logger.unknown(PROC) { INPUT_MAP[LAYOUT_DEFAULT][FUNCTION_DEFAULT][ACTION_SMS_BACK] }
                  open_dial
                when ACTION_SMS_LEFT
                  logger.unknown(PROC) { INPUT_MAP[LAYOUT_DEFAULT][FUNCTION_DEFAULT][ACTION_SMS_LEFT] }
                when ACTION_SMS_RIGHT
                  logger.unknown(PROC) { INPUT_MAP[LAYOUT_DEFAULT][FUNCTION_DEFAULT][ACTION_SMS_RIGHT] }
                when ACTION_SMS_CENTRE
                  logger.unknown(PROC) { INPUT_MAP[LAYOUT_DEFAULT][FUNCTION_DEFAULT][ACTION_SMS_CENTRE] }
                end
              when LAYOUT_SMS_SHOW
                case index
                when ACTION_SMS_BACK
                  logger.unknown(PROC) { INPUT_MAP[LAYOUT_DEFAULT][FUNCTION_DEFAULT][ACTION_SMS_BACK] }
                  generate_sms_index
                when ACTION_SMS_LEFT
                  logger.unknown(PROC) { INPUT_MAP[LAYOUT_DEFAULT][FUNCTION_DEFAULT][ACTION_SMS_LEFT] }
                when ACTION_SMS_RIGHT
                  logger.unknown(PROC) { INPUT_MAP[LAYOUT_DEFAULT][FUNCTION_DEFAULT][ACTION_SMS_RIGHT] }
                when ACTION_SMS_CENTRE
                  logger.unknown(PROC) { INPUT_MAP[LAYOUT_DEFAULT][FUNCTION_DEFAULT][ACTION_SMS_CENTRE] }
                end
              end
            end

            def delegate_contact(layout, button)
              logger.unknown(PROC) { "#delegate_contact(#{layout}, #{button})" }
              index = button_id(button)
              logger.unknown(PROC) { INPUT_MAP[layout.value][FUNCTION_CONTACT][index] }

              case layout.value
              when LAYOUT_DIRECTORY
                directory_name(INPUT_MAP[layout.value][FUNCTION_CONTACT][index])
              when LAYOUT_TOP_8
                top_8_name(INPUT_MAP[layout.value][FUNCTION_CONTACT][index])
              end
            end

            def delegate_digit(layout, button)
              logger.unknown(PROC) { "#delegate_digit(#{layout}, #{button})" }
              index = button_id(button)
              case layout.value
              when LAYOUT_PIN
                logger.unknown(PROC) { "Pin: #{INPUT_MAP[layout.value][FUNCTION_DIGIT][index]}" }
                return pin_delete if index == ACTION_PIN_DELETE
                return pin_flush & open_dial if index == ACTION_PIN_OK
                pin_number(INPUT_MAP[LAYOUT_PIN][FUNCTION_DIGIT][index])
              when LAYOUT_DIAL
                logger.unknown(PROC) { "Dial: #{INPUT_MAP[layout.value][FUNCTION_DIGIT][index]}" }
                return dial_delete if index == ACTION_DIAL_DELETE
                dial_number(INPUT_MAP[LAYOUT_DIAL][FUNCTION_DIGIT][index])
              end
            end

            def delegate_sos(layout)
              logger.unknown(PROC) { "#delegate_sos(#{layout})" }
              logger.unknown(PROC) { INPUT_MAP[layout.value][FUNCTION_SOS][ACTION_SOS_OPEN] }
              open_sos
            end

            def delegate_navigation(layout, button)
              logger.unknown(PROC) { "#delegate_navigation(#{layout}, #{button})" }
              index = button_id(button)
              case index
              when ACTION_DIAL_OPEN
                logger.unknown(PROC) { INPUT_MAP[layout.value][FUNCTION_NAVIGATE][ACTION_DIAL_OPEN] }
                open_dial
              when ACTION_SMS_OPEN
                logger.unknown(PROC) { INPUT_MAP[layout.value][FUNCTION_NAVIGATE][ACTION_SMS_OPEN] }
                generate_sms_index
              when ACTION_DIR_OPEN
                logger.unknown(PROC) { INPUT_MAP[layout.value][FUNCTION_NAVIGATE][ACTION_DIR_OPEN] }
                generate_directory
              else
              end
            end

            def delegate_info(layout)
              logger.unknown(PROC) { "#delegate_info" }
              logger.unknown(PROC) { INPUT_MAP[layout.value][FUNCTION_INFO][ACTION_INFO_OPEN] }
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
          end
        end
      end
    end
  end
end
