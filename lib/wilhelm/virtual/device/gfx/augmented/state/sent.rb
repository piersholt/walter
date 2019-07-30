# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GFX
        class Augmented < Device::Augmented
          module State
            # GFX::Augmented::State::Sent
            module Sent
              include Virtual::Constants::Events::Display
              include Virtual::Constants::Controls::BMBT
              include Constants

              # Command 0x01 PING
              def evaluate_ping(*)
                changed
                notify_observers(GFX_PING, device: moi)
              end

              # Command 0x02 PONG
              def evaluate_pong(command)
                case command.status.value
                when 0x40
                  changed
                  notify_observers(GFX_ANNOUNCE, device: moi)
                end
              end

              # Command 0x31 INPUT
              def evaluate_input(command)
                case command.source.value
                when RADIO_LAYOUTS
                  index = button_id(command.action)
                  state = button_state(command.action)
                  changed
                  notify_observers(GFX_DATA_SELECT, index: index, state: state)
                end
              end

              # Command 0x45 MENU-GFX
              def evaluate_menu_gfx(command)
                case command.config.value
                when HIDE_RADIO
                  changed
                  notify_observers(BMBT_MENU, device: :gfx)
                end
              end

              # Command 0x4F SRC-GFX
              def evaluate_src_gfx(command)
                case command.action.value
                when MONITOR_ON
                  monitor_off
                when MONITOR_OFF
                  monitor_on
                end
              end

              # Command 0x41 OBC_BOOL
              def evaluate_obc_bool(command)
                id = command.field.value
                return false unless OBC_PARAMS.include?(id)
                changed
                notify_observers(
                  GFX_OBC_BOOL,
                  device: moi,
                  menu: :on_board_computer
                )
              end

              private

              def button_id(action)
                action.parameters[:button_id].value
              end

              def button_state(action)
                action.parameters[:button_state].value
              end
            end
          end
        end
      end
    end
  end
end
