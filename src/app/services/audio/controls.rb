# frozen_string_literal: true

module Wolfgang
  class Audio
    # Comment
    module Controls
      include SDK::Controls::Register
      include Logging

      LOGGER_NAME = AUDIO_CONTROLS

      CONTROL_REGISTER = {
        BMBT_POWER => STATELESS_CONTROL,
        BMBT_NEXT => TWO_STAGE_CONTROL,
        BMBT_PREV => TWO_STAGE_CONTROL,
        MFL_NEXT => TWO_STAGE_CONTROL,
        MFL_PREV => TWO_STAGE_CONTROL,
        MFL_TEL => STATELESS_CONTROL
      }.freeze

      CONTROL_ROUTES = {
        BMBT_POWER => { power: STATELESS },
        BMBT_NEXT => { seek_forward: STATELESS,
                       scan_forward: STATEFUL },
        MFL_NEXT => { seek_forward: STATELESS,
                      scan_forward: STATEFUL },
        BMBT_PREV => { seek_backward: STATELESS,
                       scan_backward: STATEFUL },
        MFL_PREV => { seek_backward: STATELESS,
                      scan_backward: STATEFUL },
        MFL_TEL => { pause: STATELESS }
      }.freeze
    end
  end
end
