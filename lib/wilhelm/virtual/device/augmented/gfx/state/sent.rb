# frozen_string_literal: true

class Wilhelm::Virtual
  class AugmentedGFX < AugmentedDevice
    module State
      # Comment
      module Sent
        include Events

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
            notify_observers(DATA_SELECT, index: index, state: state)
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
          if [0x03, 0x04, 0x05, 0x06, 0x09, 0x0a, 0x0e].include?(id)
            changed
            notify_observers(GFX_OBC_REQ, device: moi)
          end
        end
      end
    end
  end
end
