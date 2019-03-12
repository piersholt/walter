# frozen_string_literal: true

module Wolfgang
  class Service
    # Comment
    module Controls
      include Logger
      include SDK::Controls::Register

      LOGGER_NAME = WOLFGANG

      CONTROL_REGISTER = {
        BMBT_AUX_HEAT => STATELESS_CONTROL
      }.freeze

      CONTROL_ROUTES = {
        BMBT_AUX_HEAT => { load_ui: :stateless }
      }.freeze

      def load_ui
        logger.debug(AUDIO) { '#load_ui()' }
        @state.load_ui(self)
      end
    end
  end
end
