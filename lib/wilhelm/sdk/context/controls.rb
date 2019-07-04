# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class ServicesContext
        # Context::Services::Controls
        module Controls
          include Logging
          include Wilhelm::SDK::Controls::Register

          LOGGER_NAME = WILHELM

          CONTROL_REGISTER = {
            BMBT_AUX_HEAT => STATELESS_CONTROL
          }.freeze

          CONTROL_ROUTES = {
            BMBT_AUX_HEAT => { load_debug: :stateless }
          }.freeze

          # TODO: these needs to be programatically added by services

          def load_debug
            logger.debug(LOGGER_NAME) { '#load_debug()' }
            @state.load_debug(self)
          end

          def load_services
            logger.debug(LOGGER_NAME) { '#load_services()' }
            @state.load_services(self)
          end
        end
      end
    end
  end
end
