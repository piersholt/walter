# frozen_string_literal: true

puts 'Loading wilhelm/virtual/helpers/console'
require_relative 'console/display'
puts "\tDone!"

module Wilhelm
  class Virtual
    module Helpers
      # Comment
      module Console
        include Wilhelm::Helpers::Console
        include Display

        def apply_debug_defaults
          LOGGER.info(PROC_MOD) { 'Applying console defaults.' }
          shutup!
        end
      end
    end
  end
end
