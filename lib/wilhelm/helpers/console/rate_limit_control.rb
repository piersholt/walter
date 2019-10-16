# frozen_string_literal: false

module Wilhelm
  module Helpers
    module Console
      # Console::RateLimitControl
      module RateLimitControl
        def interface_read_thread
          @core.interface.read_thread
        end

        alias t interface_read_thread

        def nap(seconds)
          t.thread_variable_set(:sleep_time, seconds)
        end

        def sleepy?
          t.thread_variable_get(:sleep_enabled)
        end

        def awake!
          t.thread_variable_set(:sleep_enabled, false)
        end

        def sleepy!
          t.thread_variable_set(:sleep_enabled, true)
        end
      end
    end
  end
end
