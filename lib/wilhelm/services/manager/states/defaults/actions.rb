# frozen_string_literal: false

module Wilhelm
  module Services
    class Manager
      module Defaults
        # Unimplemented methods fallback for actions
        module Actions
          def connect_device(*); end

          def disconnect_device(*); end

          # UI

          def load_manager(*); end
        end
      end
    end
  end
end
