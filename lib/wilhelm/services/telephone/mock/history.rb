# frozen_string_literal: false

module Wilhelm
  module Services
    class Telephone
      module Mock
        # Contact Generators
        module History
          HISTORY = [
            "+61#{Array.new(9,0).join}",
            "+61#{Array.new(9,1).join}",
            "+61#{Array.new(9,2).join}",
            "+61#{Array.new(9,3).join}",
            "+61#{Array.new(9,4).join}",
            "+61#{Array.new(9,5).join}",
            "+61#{Array.new(9,6).join}",
            "+61#{Array.new(9,7).join}",
            "+61#{Array.new(9,8).join}",
            "+61#{Array.new(9,9).join}"
          ].freeze

          def history
            @history ||= HISTORY.dup
          end
        end
      end
    end
  end
end
