# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Controls
      module Controls
        include Wilhelm::SDK::Controls::Register
        include Logging

        LOGGER_NAME = AUDIO_CONTROLS

        CONTROL_REGISTER = {
          BMBT_MODE_PREV    => STATELESS_CONTROL,
          BMBT_OVERLAY      => STATELESS_CONTROL,
          BMBT_POWER        => STATELESS_CONTROL,
          BMBT_NEXT         => TWO_STAGE_CONTROL,
          BMBT_PREV         => TWO_STAGE_CONTROL,
          MFL_NEXT_RAD      => TWO_STAGE_CONTROL,
          MFL_PREV_RAD      => TWO_STAGE_CONTROL,
          MFL_TEL           => STATELESS_CONTROL,
          MFL_VOL_UP_RAD    => STATELESS_CONTROL,
          MFL_VOL_DOWN_RAD  => STATELESS_CONTROL,
          BMBT_VOL_UP_RAD   => STATELESS_CONTROL,
          BMBT_VOL_DOWN_RAD => STATELESS_CONTROL
        }.freeze

        CONTROL_ROUTES = {
          # @todo check if BMBT emits MODE_NEXT
          BMBT_MODE_PREV => {
            load_audio: STATELESS
          },
          BMBT_OVERLAY => {
            load_now_playing: STATELESS
          },
          BMBT_POWER => {
            power: STATELESS
          },
          BMBT_NEXT => {
            seek_forward: STATELESS,
            scan_forward: STATEFUL
          },
          MFL_NEXT_RAD => {
            seek_forward: STATELESS,
            scan_forward: STATEFUL
          },
          BMBT_PREV => {
            seek_backward: STATELESS,
            scan_backward: STATEFUL
          },
          MFL_PREV_RAD => {
            seek_backward: STATELESS,
            scan_backward: STATEFUL
          },
          MFL_TEL => {
            pause: STATELESS
          },
          MFL_VOL_UP_RAD => {
            volume_up: STATELESS
          },
          MFL_VOL_DOWN_RAD => {
            volume_down: STATELESS
          },
          BMBT_VOL_UP_RAD => {
            volume_up: STATELESS
          },
          BMBT_VOL_DOWN_RAD => {
            volume_down: STATELESS
          }
        }.freeze
      end
    end
  end
end
