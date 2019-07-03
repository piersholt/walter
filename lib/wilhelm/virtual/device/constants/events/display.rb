# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Events
        # Virtual::Device::GFX Events
        module Display
          # State related events
          module State
            GFX_MONITOR_ON     = :gfx_monitor_on
            GFX_MONITOR_OFF    = :gfx_monitor_off
            GFX_PING           = :gfx_ping
            GFX_ANNOUNCE       = :gfx_announce
            GFX_OBC_BOOL       = :gfx_obc_req
            RADIO_BODY_CLEARED = :radio_body_cleared
            # Not In Use
            PRIORITY_GFX              = :gfx_priority_gfx
            PRIORITY_RADIO            = :gfx_priority_radio
            RADIO_LAYOUT_SERVICE      = :radio_layout_service
            RADIO_LAYOUT_WEATHER_BAND = :radio_layout_weather_band
            RADIO_LAYOUT_RADIO        = :radio_layout_radio
            RADIO_LAYOUT_DIGITAL      = :radio_layout_digital
            RADIO_LAYOUT_TAPE         = :radio_layout_tape
            RADIO_LAYOUT_TRAFFIC      = :radio_layout_traffic
            RADIO_LAYOUT_CDC          = :radio_layout_cdc
            RADIO_LAYOUT_UNKNOWN      = :radio_layout_unknown
          end

          # Input related events
          module Input
            # Note: this is basically just 0x31 from GFX to RAD/TEL
            DATA_SELECT = :data_select
            # Generic event used for any buttons- button specifics are handled
            # by the observers
            BMBT_BUTTON = :button
          end

          # Cache related events
          module Cache
            HEADER_CACHE = :header_cache
            HEADER_WRITE = :header_write
            MENU_CACHE   = :menu_cache
            MENU_WRITE   = :menu_write
          end

          include State
          include Input
          include Cache
        end
      end
    end
  end
end
