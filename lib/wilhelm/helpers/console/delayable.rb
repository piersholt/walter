# frozen_string_literal: false

module Wilhelm
  module Helpers
    module Console
      # Console::Delayable
      module Delayable
        def interface_read_thread
          @core.interface.read_thread
        end

        def nap(seconds)
          # interface_read_thread[:sleep_time] = seconds
          interface_read_thread.thread_variable_set(:sleep_time, seconds)
        end

        def sleepy?
          # interface_read_thread[:sleep_enabled] = false
          interface_read_thread.thread_variable_get(:sleep_enabled)
        end

        def awake!
          t = interface_read_thread
          # interface_read_thread[:sleep_enabled] = false
          t.thread_variable_set(:sleep_enabled, false)
          # puts "[#{t[:name]}] :sleep_enabled => #{sleepy?}"
        end

        def sleepy!
          t = interface_read_thread
          # interface_read_thread[:sleep_enabled] = true
          t.thread_variable_set(:sleep_enabled, true)
          # puts "[#{t[:name]}] :sleep_enabled => #{sleepy?}"
        end
      end
    end
  end
end
