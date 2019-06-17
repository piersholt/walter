# frozen_string_literal: false

module Wilhelm
  module Core
    # DebugTools
    # Helpers for common tasks on CLI
    module Debug
      include Delayable
      include Display
      include Session
      include Threads
      include Yabber

      PROC_MOD = 'Debug'.freeze

      def apply_debug_defaults
        LOGGER.info(PROC_MOD) { 'Applying debug defaults.' }
        shutup!
      end

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
