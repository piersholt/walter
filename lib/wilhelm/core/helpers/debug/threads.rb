# frozen_string_literal: false

module Wilhelm
  module Core
    # DebugTools
    # Helpers for common tasks on CLI
    module Debug
      module Threads
        def news
          print_status(true)
          true
        end
      end
    end
  end
end
