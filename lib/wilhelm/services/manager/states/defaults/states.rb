# frozen_string_literal: false

module Wilhelm
  module Services
    class Manager
      module Defaults
        # Manager::Defaults::States
        module States
          def disable!(*); end

          def pending!(*); end

          def on!(*); end
        end
      end
    end
  end
end
