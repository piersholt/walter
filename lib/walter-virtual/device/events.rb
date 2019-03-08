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
    BMBT_LEFT = :bmbt_left
    BMBT_RIGHT = :bmbt_right
    BMBT_CONFIRM = :bmbt_confirm

    BMBT_MENU = :bmbt_menu
    BMBT_AUX_HEAT = :bmbt_aux_heat

    BMBT_POWER = :bmbt_power
    BMBT_NEXT = :bmbt_next
    BMBT_PREV = :bmbt_prev

    MFL_NEXT     = :mfl_next
    MFL_PREV     = :mfl_prev
    MFL_VOL_DOWN = :mfl_vol_down
    MFL_VOL_UP   = :mfl_vol_up

    MFL_TEL      = :mfl_tel
    MFL_RT_RAD   = :mfl_rt_rad
    MFL_RT_TEL   = :mfl_rt_tel

    BMBT_PLAYBACK = [BMBT_POWER, BMBT_NEXT, BMBT_PREV].freeze
    BMBT_ALL = [BMBT_MENU, BMBT_AUX_HEAT, BMBT_CONFIRM, BMBT_NEXT, BMBT_PREV, BMBT_LEFT, BMBT_RIGHT].freeze

    MFL_PLAYBACK = [MFL_NEXT, MFL_PREV, MFL_VOL_DOWN, MFL_VOL_UP].freeze
    MFL_ALL = [MFL_NEXT, MFL_PREV, MFL_VOL_DOWN, MFL_VOL_UP, MFL_TEL, MFL_RT_RAD, MFL_RT_TEL].freeze

    def bmbt?(command_argument)
      BMBT_ALL.include?(command_argument)
    end

    def mfl?(command_argument)
      MFL_ALL.include?(command_argument)
    end
  end
end

class Vehicle
  module Events
    include States
    include Commands
    include Buttons
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
