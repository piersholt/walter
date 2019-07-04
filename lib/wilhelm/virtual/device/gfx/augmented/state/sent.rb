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
              include Virtual::Constants::Buttons::BMBT
              include Constants

              # Command 0x01
              def evaluate_ping(command)
                changed
                notify_observers(GFX_PING, device: moi)
              end

              # Command 0x02
              def evaluate_pong(command)
                case command.status.value
                when 0x40
                  changed
                  notify_observers(GFX_ANNOUNCE, device: moi)
                end
              end

              # source: 0x60 (RDS 1) / function: 00 (--) / action: 00 (Offset 0)
              def evaluate_tel_data(command)
                # logger.error('oh hai!') { command }
                case command.source.value
                when (0x60..0x63)
                  index = command.action.parameters[:button_id].value
                  state = command.action.parameters[:button_state].state
                  changed
                  notify_observers(GFX_DATA_SELECT, index: index, state: state)
                end
              end

              def evaluate_menu_gfx(command)
                case command.config.value
                when 0b0000_0001
                  # priority_gfx
                  # audio_obc_off
                  changed
                  notify_observers(BMBT_MENU, device: :gfx)
                when 0b0000_0011
                  # priority_gfx
                  # audio_obc_on
                when 0b1001_0001
                  # priority_gfx
                end
              end

              def evaluate_src_gfx(command)
                case command.action.value
                when 0x00
                  monitor_off
                when 0x10
                  monitor_on
                end
              end



              def evaluate_obc_req(command)
                id = command.field.value
                if OBC_PARAMS.include?(id)
                  changed
                  notify_observers(GFX_OBC_BOOL, device: moi, menu: :on_board_computer)
                end
              end
            end
          end
        end
      end
    end
  end
end
