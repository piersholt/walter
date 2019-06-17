# frozen_string_literal: true

puts 'Loading wilhelm/virtual/helpers/debug'
require_relative 'debug/display'
puts "\tDone!"

module Wilhelm
  class Virtual
    module Helpers
      # Comment
      module Debug
        include Wilhelm::Helpers::Debug
        include Display

        def apply_debug_defaults
          LOGGER.info(PROC_MOD) { 'Applying debug defaults.' }
          # shutup!
        end
      end
    end
  end
end
