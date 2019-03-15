# frozen_string_literal: true

module Wolfgang
  class Service
    # Comment
    module Controls
      include Constants
      include SDK::Controls::Register

      LOGGER_NAME = WOLFGANG

      CONTROL_REGISTER = {
        BMBT_AUX_HEAT => STATELESS_CONTROL,
        BMBT_OVERLAY => STATELESS_CONTROL
      }.freeze

      CONTROL_ROUTES = {
        BMBT_AUX_HEAT => { load_debug: :stateless },
        BMBT_OVERLAY => { load_audio: :stateless }
      }.freeze

      def load_debug
        logger.debug(AUDIO) { '#load_debug()' }
        # @state.load_debug(self)
        # ui.load_debug
        ui.launch(:debug, :index)
      end

      def load_audio
        logger.debug(AUDIO) { '#load_audio()' }
        # ui.load_audio
        ui.launch(:audio, :now_playing)
      end
    end
  end
end
