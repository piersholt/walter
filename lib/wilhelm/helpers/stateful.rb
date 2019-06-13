# frozen_string_literal: false

module Wilhelm
  module Helpers
    # Attribute helpers used for building state
    module Stateful
      def state
        @state ||= default_state
      end

      private

      def state!(delta)
        state.merge!(delta) do |_, val_old, val_new|
          if val_old.is_a?(Hash) && val_new.is_a?(Hash)
            val_old.merge(val_new)
          else
            val_new
          end
        end
      end

      def default_state
        raise StandardError, 'Inheriting class has not implemented default state!'
      end
    end
  end
end
