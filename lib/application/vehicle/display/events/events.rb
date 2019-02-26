# frozen_string_literal: false

class Vehicle
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

  # Should commands that do not affect module state be relayed...?
  module Commands
    GFX_PING = :gfx_ping
    GFX_ANNOUNCE = :gfx_announce

    GFX_OBC_REQ = :gfx_obc_req

    DATA_SELECT = :data_select
  end
  
  module Buttons
    BMBT_MENU = :bmbt_menu
    BMBT_AUX_HEAT = :bmbt_aux_heat
    BMBT_CONFIRM = :bmbt_confirm
    BMBT_NEXT = :bmbt_next
    BMBT_PREV = :bmbt_prev
    BMBT_LEFT = :bmbt_left
    BMBT_RIGHT = :bmbt_right
  end
end

class Virtual
  # Vehicle Events
  module Events
    include Vehicle::States
    include Vehicle::Commands
    include Vehicle::Buttons
  end
end
