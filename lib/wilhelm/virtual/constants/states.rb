# frozen_string_literal: false

class Wilhelm::Virtual
  module Constants
    module States
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

      RADIO_BODY_CLEARED = :radio_body_cleared

      GFX_MONITOR_ON  = :gfx_monitor_on
      GFX_MONITOR_OFF = :gfx_monitor_off
    end
  end
end
