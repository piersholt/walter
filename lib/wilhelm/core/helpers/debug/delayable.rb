# frozen_string_literal: false

module Wilhelm
  module Core
    # DebugTools
    # Helpers for common tasks on CLI
    module Debug
      module Delayable
        def nap(seconds)
          # @interface.read_thread[:sleep_time] = seconds
          @interface.read_thread.thread_variable_set(:sleep_time, seconds)
        end

        def sleepy?
          # @interface.read_thread[:sleep_enabled] = false
          @interface.read_thread.thread_variable_get(:sleep_enabled)
        end

        def awake!
          t = @interface.read_thread
          # @interface.read_thread[:sleep_enabled] = false
          t.thread_variable_set(:sleep_enabled, false)
          # puts "[#{t[:name]}] :sleep_enabled => #{sleepy?}"
        end

        def sleepy!
          t = @interface.read_thread
          # @interface.read_thread[:sleep_enabled] = true
          t.thread_variable_set(:sleep_enabled, true)
          # puts "[#{t[:name]}] :sleep_enabled => #{sleepy?}"
        end
      end
    end
  end
end
