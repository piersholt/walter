# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class ServicesContext
        # Context::Services::Controls
        module Controls
          include Logging
          include Wilhelm::SDK::Controls::Register

          CONTROL_REGISTER = {
            BMBT_AUX_HEAT => TWO_STAGE_CONTROL
          }.freeze

          CONTROL_ROUTES = {
            BMBT_AUX_HEAT => {
              load_context: :stateless,
              shutdown: :stateful
            }
          }.freeze
        end
      end
    end
  end
end
