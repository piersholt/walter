# frozen_string_literal: false

puts "\tLoading wilhelm/helpers/console"

require_relative 'console/delayable'
require_relative 'console/session'
require_relative 'console/threads'
# require_relative 'console/yabber'
# require_relative 'console/frames'

module Wilhelm
  module Helpers
    # Helpers::Console
    # Helpers for common tasks in console mode (pry).
    module Console
      include Delayable
      include Session
      include Threads
      # include Yabber

      PROC_MOD = 'Console'.freeze
      NEW_LINE = 'New Line'

      def command_map
        Wilhelm::Virtual::Map::Command.instance
      end

      def nl
        new_line_thread = Thread.new do
          Thread.current[:name] = NEW_LINE
          Kernel.sleep(0.5)
          LOGGER.unknown(PROC_MOD) { NEW_LINE }
        end
        add_thread(new_line_thread)
      end
    end
  end
end
