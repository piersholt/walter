# frozen_string_literal: false

module Wilhelm
  module Helpers
    # DebugTools
    # Helpers for common tasks on CLI
    module Console
      module Session
        def messages
          Core::SessionHandler.i.messages
        end

        def hello?
          t0 = messages.count
          Kernel.sleep(1)
          t1 = messages.count
          r = t1 - t0
          LOGGER.info(PROC_MOD) { "#{r} new messages in the last second." }
          r.positive? ? true : false
        end
      end
    end
  end
end
