# frozen_string_literal: false

module Wilhelm
  module Services
    class Manager
      module Defaults
        # Unimplemented methods fallback for actions
        module Actions
          include Logging

          def connect_device(*)
            logger.warn(MANAGER) { 'State does not implement: #connect_device' }
          end

          def disconnect_device(*)
            logger.warn(MANAGER) { 'State does not implement: #disconnect_device' }
          end

          # UI

          def load_manager(*)
            logger.warn(MANAGER) { 'State does not implement: #load_manager' }
          end
        end
      end
    end
  end
end
