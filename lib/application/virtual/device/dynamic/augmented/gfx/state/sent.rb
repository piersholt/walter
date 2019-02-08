# frozen_string_literal: true

class Virtual
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

        def evaluate_menu_gfx(command)
          case command.config.value
          when 0b0000_0001
            # priority_gfx
            # audio_obc_off
            changed
            notify_observers(INPUT_MENU, device: :gfx)
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
          changed
          notify_observers(GFX_OBC_REQ, device: moi)
        end
      end
    end
  end
end
