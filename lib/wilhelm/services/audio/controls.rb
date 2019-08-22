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
          BMBT_MODE => STATELESS_CONTROL,
          BMBT_OVERLAY => STATELESS_CONTROL,
          BMBT_POWER => STATELESS_CONTROL,
          BMBT_NEXT => TWO_STAGE_CONTROL,
          BMBT_PREV => TWO_STAGE_CONTROL,
          MFL_NEXT_RAD => TWO_STAGE_CONTROL,
          MFL_PREV_RAD => TWO_STAGE_CONTROL,
          MFL_TEL => STATELESS_CONTROL,
          MFL_VOL_RAD_UP => STATELESS_CONTROL,
          MFL_VOL_RAD_DOWN => STATELESS_CONTROL,
          BMBT_VOL_RAD_UP => STATELESS_CONTROL,
          BMBT_VOL_RAD_DOWN => STATELESS_CONTROL
        }.freeze

        CONTROL_ROUTES = {
          BMBT_MODE => {
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
          MFL_VOL_RAD_UP => {
            volume_up: STATELESS
          },
          MFL_VOL_RAD_DOWN => {
            volume_down: STATELESS
          },
          BMBT_VOL_RAD_UP => {
            volume_up: STATELESS
          },
          BMBT_VOL_RAD_DOWN => {
            volume_down: STATELESS
          }
        }.freeze
      end
    end
  end
end
