# frozen_string_literal: false

puts "\tLoading wilhelm/helpers/console"

require_relative 'console/delayable'
require_relative 'console/session'
require_relative 'console/threads'
# require_relative 'console/yabber'
# require_relative 'console/frames'

module Wilhelm
  module Helpers
    # DebugTools
    # Helpers for common tasks on CLI
    module Console
      include Delayable
      include Session
      include Threads
      # include Yabber

      def command_map
        Wilhelm::Virtual::CommandMap.instance
      end

      PROC_MOD = 'Console'.freeze

      def nl
        new_line_thread = Thread.new do
          Thread.current[:name] = 'New Line'
          Kernel.sleep(0.5)
          LOGGER.unknown('Walter') { 'New Line' }
        end
        add_thread(new_line_thread)
      end
    end
  end
end
