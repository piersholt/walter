class Virtual
  module Events
    RADIO_LAYOUT_SERVICE = :radio_layout_service
    RADIO_LAYOUT_WEATHER_BAND = :radio_layout_weather_band
    RADIO_LAYOUT_RADIO = :radio_layout_radio
    RADIO_LAYOUT_DIGITAL = :radio_layout_digital
    RADIO_LAYOUT_TAPE = :radio_layout_tape
    RADIO_LAYOUT_TRAFFIC = :radio_layout_traffic
    RADIO_LAYOUT_CDC = :radio_layout_cdc
    RADIO_LAYOUT_UNKNOWN = :radio_layout_unknown

    GFX_IDLE = :gfx_priority_gfx
    GFX_BUSY  = :gfx_priority_radio

    GFX_MONITOR_ON  = :gfx_monitor_on
    GFX_MONITOR_OFF = :gfx_monitor_off

    INPUT_CONFIRM_SELECT = :input_confirm_select
    INPUT_CONFIRM_HOLD = :input_confirm_hold
    INPUT_CONFIRM_RELEASE = :input_confirm_release

    INPUT_LEFT = :input_left
    INPUT_RIGHT = :input_right
  end
end
