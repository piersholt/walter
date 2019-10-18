# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::Received
          module Received
            include Virtual::Constants::Events::Telephone
            include Constants

            LOG_ERROR_BRANCH = 'No matching branch!'

            # 0x02 PONG
            # Piggyback off the radio announce to annunce
            def handle_pong(message)
              return false unless message.from?(:gt)
              return false unless message.command.status.value == ANNOUNCE
              logger.info(PROC) { "GT has announced. Piggybacking (sic)" }
              ready
              true
            end

            # 0x20 TEL-OPEN
            def handle_tel_open(*)
              logger.debug(PROC) { '#handle_tel_open' }
              logger.debug(PROC) { "@layout=#{layout}" }
              return dial_open if background?
              return top_8_open if dial? || last_numbers?
              logger.warn(PROC) { "No state to interpret TEL-OPEN!(#{layout})" }
              dial_open
            end

            # 0x31 INPUT
            # Hold and Release are filtered
            def handle_input(command)
              return false unless command.press?
              logger.debug(PROC) { '#handle_input(command)' }
              logger.debug(PROC) { "@layout=#{layout}" }

              case command.layout.ugly
              when :default
                return handle_last_numbers(command) if dial? || last_numbers?
                return handle_directory(command) if directory?
                logger.warn(PROC) { "No state to interpret INPUT 0x00! (#{layout})" }
                return handle_default(command)
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
                return handle_sms_show(command) if sms_index? || sms_show?
                return handle_sos(command) if sos?
                logger.warn(PROC) { "No state to interpret INPUT 0xf1! (#{layout})" }
                raise(ArgumentError, '0x31 has layout 0xf1, but @layout is not :sms, :smses, or :sos!' )
              end
            end

            private

            # 0x32 MFL_VOL
            def handle_mfl_vol(command)
              logger.debug(ident) { "MFL_VOL -> #{command.pretty}" }
              notify_of_button(command)
            end

            # 0x3B MFL_FUNC
            # @note R/T is has no button state!
            def handle_mfl_func(command)
              logger.debug(ident) { "MFL_FUNC -> #{command.pretty} (#{command.button})" }
              notify_of_button(command)

              case command.button
              when :mfl_rt_rad
                quick_disable
              when :mfl_rt_tel
                quick_enable
              when :mfl_tel_next
                return false unless command.release?
                quick_forward
              when :mfl_tel_prev
                return false unless command.release?
                quick_back
              when :mfl_tel
                return false unless command.release?
                case inactive?
                when true
                  active.handsfree.status!
                  quick_call_start
                when false
                  inactive.handset.status!
                  quick_call_end
                end
              end
            end

            # 0x48 BMBT_A
            def handle_bmbt_button_1(command)
              logger.debug(ident) { "BMBT_A -> #{command.pretty}" }
              return false unless command.press?
              case command.button
              when :bmbt_menu
                background!
              end
            end

            # 0xA2 COORD
            # def handle_telematics_coord(*); end
            # see SOS::Handler

            # 0xA4 ADDR
            # def handle_telematics_addr(*); end
            # see SOS::Handler

            protected

            def unknown_function(command)
              logger.warn(PROC) { "Unrecognised function! #{command}" }
            end

            def twig(layout, function, action)
              INPUT_MAP.dig(layout, function, action) || raise(ArgumentError, LOG_ERROR_BRANCH)
            end

            def branch(layout, function, action)
              logger.debug(PROC) { "\"#{twig(layout, function, action)}\"" }
            end

            private

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

            def button_id(action)
              action.parameters[:id].value
            end

            def notify_of_button(command)
              changed
              notify_observers(
                TELEPHONE_BUTTON,
                control: command.button,
                state: command.state,
                source: :mfl
              )
            end
          end
        end
      end
    end
  end
end
