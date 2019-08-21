# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Events
        # Virtual::Device::GFX Events
        module Display
          # Cache related events
          module Cache
            HEADER_CACHE = :header_cache
            HEADER_WRITE = :header_write
            MENU_CACHE   = :menu_cache
            MENU_WRITE   = :menu_write
          end

          # Control related events
          module Control
            GFX_CONTROL = :data_select
          end

          # State related events
          module State
            GFX_MONITOR_ON     = :gfx_monitor_on
            GFX_MONITOR_OFF    = :gfx_monitor_off
            GFX_PING           = :gfx_ping
            GFX_ANNOUNCE       = :gfx_announce
            GFX_OBC_BOOL       = :gfx_obc_req

            GFX_STATES = constants.map { |i| const_get(i) }
          end

          include Cache
          include Control
          include State
        end
      end
    end
  end
end
