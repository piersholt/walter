# frozen_string_literal: true

module Wilhelm
  module Helpers
    # Helpers::Inspect
    module Inspect
      include Object

      def inspect
        "#<#{self.class}:#{id_encoded(self)} #{variables_inspect}>"
      end

      def variables_inspect
        instance_variables.map do |variable|
          "#{variable}=#{instance_variable_get(variable).send(:inspect)}"
        end&.join(' ')
      end
    end
  end
end
