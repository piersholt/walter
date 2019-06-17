# frozen_string_literal: false

module Wilhelm
  module Helpers
    # DebugTools
    # Helpers for common tasks on CLI
    module Console
      module Threads
        def news
          print_status(true)
          true
        end
      end
    end
  end
end
