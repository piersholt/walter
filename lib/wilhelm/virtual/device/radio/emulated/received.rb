# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        class Emulated < Device::Emulated
          # Radio::Emulated::Received
          module Received
            include Virtual::Constants::Events::Radio
            include Constants

            # MENU_GT 0x45
            def handle_menu_gt(command)
              case Kernel.format('%8.8b', command.config.value)[7]
              when '1'
                acknowledge_menu
              end
            end

            # MFL_VOL 0x32
            def handle_mfl_vol(command)
              logger.debug(ident) { "MFL_VOL -> #{command.pretty}" }
              notify_of_button(command)
            end

            # MFL_FUNC 0x3B
            def handle_mfl_func(command)
              logger.debug(ident) { "MFL_FUNC -> #{command.pretty}" }
              notify_of_button(command)
            end

            # BMBT_A 0x48
            def handle_bmbt_button_1(command)
              logger.debug(ident) { "BMBT_A -> #{command.pretty}" }
              # notify_of_button(command)
            end

            private

            def notify_of_button(command)
              changed
              notify_observers(
                RADIO_BUTTON,
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
