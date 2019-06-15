# frozen_string_literal: false

module Wilhelm
  class Virtual
    module Constants
      module Events
        module Display
          module State
            GFX_MONITOR_ON  = :gfx_monitor_on
            GFX_MONITOR_OFF = :gfx_monitor_off
            GFX_PING = :gfx_ping
            GFX_ANNOUNCE = :gfx_announce
            GFX_OBC_REQ = :gfx_obc_req
            RADIO_BODY_CLEARED = :radio_body_cleared
            # Not In Use
            PRIORITY_GFX = :gfx_priority_gfx
            PRIORITY_RADIO = :gfx_priority_radio
            RADIO_LAYOUT_SERVICE = :radio_layout_service
            RADIO_LAYOUT_WEATHER_BAND = :radio_layout_weather_band
            RADIO_LAYOUT_RADIO = :radio_layout_radio
            RADIO_LAYOUT_DIGITAL = :radio_layout_digital
            RADIO_LAYOUT_TAPE = :radio_layout_tape
            RADIO_LAYOUT_TRAFFIC = :radio_layout_traffic
            RADIO_LAYOUT_CDC = :radio_layout_cdc
            RADIO_LAYOUT_UNKNOWN = :radio_layout_unknown
          end

          module Input
            DATA_SELECT = :data_select
          end

          include State
          include Input
        end
      end
    end
  end
end
