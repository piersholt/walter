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
              logger.unknown(PROC) { "@layout=#{@layout}" }
              return top_8! && generate_top_8 if dial?
              dial! && open_dial
            end

            # 0x31 INPUT
            # Hold and Release are filtered
            def handle_input(command)
              return false unless press?(command)
              logger.debug(PROC) { '#handle_input(command)' }
              logger.unknown(PROC) { "@layout=#{@layout}" }

              # NOTE: avoid routing common functions through layouts?
              # case command.function.value
              # when FUNCTION_SOS
              #   return delegate_sos(command)
              # when FUNCTION_NAVIGATE
              #   return delegate_navigation(command)
              # when FUNCTION_INFO
              #   return delegate_info(command)
              # end

              case command.layout.ugly
              when :default
                return handle_default(command) unless command.function.value.zero?
                return handle_dial(command) if dial?
                return handle_directory(command) if directory?
                raise(ArgumentError, 'Default not Dial or Directory!')
              when :pin
                return handle_pin(command)
              when :info
                return handle_info(command)
              when :dial
                return handle_dial(command)
              when :directory
                return handle_directory(command)
              when :top_8
                return handle_top_8(command)
              when :sms_index
                return handle_sms_index(command)
              when :sms_show
                return handle_sms_show(command)
              end
            end

            def handle_mfl_vol(*)
              true
            end

            def handle_mfl_func(*)
              true
            end

            protected

            # 0x00
            def handle_default(command)
              logger.unknown(PROC) { "#handle_default(#{command})" }
              case command.function.value
              when FUNCTION_SOS
                delegate_sos(command)
              else
                unknown_function(command)
              end
            end

            # 0x05
            def handle_pin(command)
              logger.unknown(PROC) { "#handle_pin(#{command})" }
              case command.function.value
              when FUNCTION_DIGIT
                index = button_id(command.button)
                branch(FUNCTION_DIGIT, FUNCTION_DIGIT, index)
                return pin_delete if index == ACTION_PIN_DELETE
                return pin_flush && dial! && open_dial if index == ACTION_PIN_OK
                pin_number(twig(LAYOUT_PIN, FUNCTION_DIGIT, index))
              when FUNCTION_SOS
                delegate_sos(command)
              else
                unknown_function(command)
              end
            end

            # 0x20
            def handle_info(command)
              logger.unknown(PROC) { "#handle_info(#{command})" }
              case command.function.value
              when FUNCTION_NAVIGATE
                delegate_navigation(command)
              else
                unknown_function(command)
              end
            end

            # 0x42
            def handle_dial(command)
              logger.unknown(PROC) { "#handle_dial(#{command})" }
              dial!
              case command.function.value
              when FUNCTION_DEFAULT
                case command.button.value
                when ACTION_RECENT_BACK
                  branch(LAYOUT_DIAL, FUNCTION_DEFAULT, ACTION_RECENT_BACK)
                  recent_contact
                when ACTION_RECENT_FORWARD
                  branch(LAYOUT_DIAL, FUNCTION_DEFAULT, ACTION_RECENT_FORWARD)
                  recent_contact
                end
              when FUNCTION_DIGIT
                index = button_id(command.button)
                branch(LAYOUT_DIAL, FUNCTION_DIGIT, index)
                return dial_delete if index == ACTION_DIAL_DELETE
                dial_number(twig(LAYOUT_DIAL, FUNCTION_DIGIT, index))
              when FUNCTION_SOS
                delegate_sos(command)
              when FUNCTION_NAVIGATE
                delegate_navigation(command)
              when FUNCTION_INFO
                delegate_info(command)
              else
                unknown_function(command)
              end
            end

            # 0x43
            def handle_directory(command)
              logger.unknown(PROC) { "#handle_directory(#{command})" }
              directory!
              case command.function.value
              when FUNCTION_DEFAULT
                case command.button.value
                when ACTION_DIRECTORY_BACK
                  branch(LAYOUT_DIRECTORY, FUNCTION_DEFAULT, ACTION_DIRECTORY_BACK)
                  directory_back
                when ACTION_DIRECTORY_FORWARD
                  branch(LAYOUT_DIRECTORY, FUNCTION_DEFAULT, ACTION_DIRECTORY_FORWARD)
                  directory_forward
                end
              when FUNCTION_CONTACT
                contact_name = twig(command.layout.value, FUNCTION_CONTACT, button_id(command.button))
                directory_name(contact_name)
              when FUNCTION_NAVIGATE
                delegate_navigation(command)
              else
                unknown_function(command)
              end
            end

            # 0x80
            def handle_top_8(command)
              logger.unknown(PROC) { "#handle_top_8(#{command})" }
              top_8!
              case command.function.value
              when FUNCTION_CONTACT
                contact_name = twig(LAYOUT_TOP_8, FUNCTION_CONTACT, button_id(command.button))
                directory_name(contact_name)
              when FUNCTION_NAVIGATE
                delegate_navigation(command)
              else
                unknown_function(command)
              end
            end

            def handle_sms_index(command)
              logger.unknown(PROC) { "#handle_sms_index(#{command})" }
              smses!
              case command.function.value
              when FUNCTION_SMS
                true
              end
            end

            def handle_sms_show(command)
              logger.unknown(PROC) { "#handle_sms_show(#{command})" }
              smses!
              case command.function.value
              when FUNCTION_NAVIGATE
                delegate_navigation(command)
              when FUNCTION_SMS
                true
              end
            end

            def unknown_function(command)
              logger.warn(PROC) { "Unrecognised function! #{command.function}" }
            end

            def twig(layout, function, action)
              INPUT_MAP.dig(layout, function, action)
            end

            def branch(layout, function, action)
              logger.unknown(PROC) { twig(layout, function, action) }
            end

            private

            # Function: 0x05
            def delegate_sos(command)
              layout = command.layout
              logger.unknown(PROC) { "#delegate_sos(#{layout})" }
              branch(layout.value, FUNCTION_SOS, ACTION_SOS_OPEN)
              sos!
              open_sos
            end

            # Function: 0x07
            def delegate_navigation(command)
              logger.unknown(PROC) { "#delegate_navigation(#{command})" }
              button = command.button
              index = button_id(command.button)
              case index
              when ACTION_SMS_INDEX_BACK
                true
              when ACTION_OPEN_DIAL
                branch(command.layout.value, FUNCTION_NAVIGATE, ACTION_OPEN_DIAL)
                dial!
                open_dial
              when ACTION_OPEN_SMS
                branch(command.layout.value, FUNCTION_NAVIGATE, ACTION_OPEN_SMS)
                smses!
                generate_sms_index
              when ACTION_OPEN_DIR
                branch(command.layout.value, FUNCTION_NAVIGATE, ACTION_OPEN_DIR)
                directory!
                generate_directory
              end
            end

            # Function: 0x08
            def delegate_info(command)
              logger.unknown(PROC) { "#delegate_info" }
              branch(command.layout.value, FUNCTION_INFO, ACTION_OPEN_INFO)
              info!
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

            def button_id(button)
              button.parameters[:id].value
            end

            def press?(command)
              button_state(command.button) == INPUT_PRESS
            end

            def release?(command)
              button_state(command.button) == INPUT_RELEASE
            end

            def button_state(button)
              button.parameters[:state].value
            end

            def dial!
              @layout = :dial
            end

            def dial?
              @layout == :dial
            end

            def directory!
              @layout = :directory
            end

            def directory?
              @layout == :directory
            end

            def top_8!
              @layout = :top_8
            end

            def top_8?
              @layout == :top_8
            end

            def info!
              @layout = :info
            end

            def info?
              @layout == :info
            end

            def sos!
              @layout = :sos
            end

            def sos?
              @layout == :sos
            end

            def smses!
              @layout = :smses
            end

            def smses?
              @layout == :smses
            end
          end
        end
      end
    end
  end
end
