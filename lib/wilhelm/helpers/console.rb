# frozen_string_literal: false

puts "\tLoading wilhelm/helpers/console"

require_relative 'console/maps'
require_relative 'console/rate_limit_control'
require_relative 'console/session'
require_relative 'console/threads'
# require_relative 'console/frames'

module Wilhelm
  module Helpers
    # Helpers::Console
    # Helpers for common tasks in console mode (pry).
    module Console
      include Maps
      include RateLimitControl
      include Session
      include Threads

      PROC_MOD = 'Console'.freeze
      NEW_LINE = 'New Line'.freeze

      def new_line
        new_line_thread = Thread.new do
          Thread.current[:name] = NEW_LINE
          Kernel.sleep(0.5)
          LOGGER.unknown(PROC_MOD) { NEW_LINE }
        end
        add_thread(new_line_thread)
      end

      alias nl new_line
    end
  end
end
