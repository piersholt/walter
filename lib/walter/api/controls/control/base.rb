# frozen_string_literal: true

class Vehicle
  class Controls
    class Control
      # Comment
      class Base
        attr_reader :control_id
        def initialize(control_id)
          @control_id = control_id
        end

        def logger
          LogActually.controls
        end

        def upgrade
          false
        end
      end
    end
  end
end
