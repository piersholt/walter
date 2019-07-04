# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Controls
      module Controls
        include Wilhelm::SDK::Controls::Register
        include Logging

        LOGGER_NAME = MANAGER_CONTROLS

        CONTROL_REGISTER = {
          BMBT_TEL => STATELESS_CONTROL
        }.freeze

        CONTROL_ROUTES = {
          BMBT_TEL => { load_manager: STATELESS }
        }.freeze
      end
    end
  end
end
