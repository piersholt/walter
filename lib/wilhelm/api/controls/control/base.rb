# frozen_string_literal: true

module Wilhelm
  module API
    class Controls
      class Control
        # Comment
        class Base
          attr_reader :control_id
          def initialize(control_id)
            @control_id = control_id
          end

          def logger
            LOGGER
          end

          def upgrade
            false
          end
        end
      end
    end
  end
end
