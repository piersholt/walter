# frozen_string_literal: true

module Wilhelm
  module Helpers
    # Attribute helpers used for building state
    module Stateful
      NO_DEFAULT_STATE = 'Inheriting class has not implemented default state!'

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
        raise(StandardError, NO_DEFAULT_STATE)
      end
    end
  end
end
