# frozen_string_literal: true

puts "\tLoading wilhelm/virtual/helpers/console"
require_relative 'console/filter'

module Wilhelm
  module Virtual
    module Helpers
      # Comment
      module Console
        include Wilhelm::Helpers::Console
        include Filter

        def apply_debug_defaults
          LOGGER.info(PROC_MOD) { 'Applying console defaults.' }
          shutup!
        end
      end
    end
  end
end
