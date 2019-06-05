# frozen_string_literal: true

module Wolfgang
  class ApplicationContext
    # Comment
    module Controls
      include Constants
      include SDK::Controls::Register

      LOGGER_NAME = WOLFGANG

      CONTROL_REGISTER = {
        BMBT_AUX_HEAT => STATELESS_CONTROL,
        BMBT_OVERLAY => STATELESS_CONTROL,
        BMBT_TEL => STATEFUL_CONTROL
      }.freeze

      CONTROL_ROUTES = {
        BMBT_AUX_HEAT => { load_debug: :stateless },
        BMBT_OVERLAY => { load_audio: :stateless },
        BMBT_TEL => { load_bluetooth: STATEFUL }
      }.freeze

      def load_debug
        logger.debug(AUDIO) { '#load_debug()' }
        @state.load_debug(self)
      end

      def load_nodes
        logger.debug(AUDIO) { '#load_nodes()' }
        @state.load_debug(self)
      end

      def load_services
        logger.debug(AUDIO) { '#load_services()' }
        @state.load_debug(self)
      end

      def load_bluetooth(*args)
        logger.debug(AUDIO) { "#load_bluetooth(#{args})" }
        @state.load_debug(self, args)
      end

      def load_audio
        logger.debug(AUDIO) { '#load_audio()' }
        @state.load_debug(self)
      end
    end
  end
end
