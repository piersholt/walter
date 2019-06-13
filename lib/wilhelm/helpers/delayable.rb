# frozen_string_literal: false

module Wilhelm
  module Helpers
    # Thread safe timing control for loops.
    module Delayable
      DEFAULT_ENABLED = true
      DEFAULT_TIME = 5

      def delay
        case sleep_enabled
        when true
          LogActually.send(log).debug(Thread.current[:name]) { 'You go sleep now.' }
          Kernel.sleep(sleep_time)
          true
        when false
          LogActually.send(log).debug(Thread.current[:name]) { 'Go go go!' }
          false
        end
      end

      def delay_defaults
        sleep_enabled!
        sleep_time!
      end

      def sleep_enabled?
        LogActually.send(log).debug(Thread.current[:name]) { ":sleep_enabled => #{sleep_enabled}" }
        sleep_enabled
      end

      def nap(seconds)
        Thread.current.thread_variable_set(:sleep_time, seconds)
      end

      private

      def sleep_enabled
        Thread.current.thread_variable_get(:sleep_enabled)
      end

      def sleep_enabled!
        LogActually.send(log).debug(Thread.current[:name]) { ":sleep_enabled = #{DEFAULT_ENABLED}" }
        Thread.current.thread_variable_set(:sleep_enabled, DEFAULT_ENABLED)
      end

      def sleep_time
        Thread.current.thread_variable_get(:sleep_time)
      end

      def sleep_time!
        LogActually.send(log).debug(Thread.current[:name]) { ":sleep_time = #{DEFAULT_TIME}" }
        Thread.current.thread_variable_set(:sleep_time, DEFAULT_TIME)
      end
    end
  end
end
