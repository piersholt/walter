# frozen_string_literal: true

puts "\tLoading wilhelm/virtual/helpers/console"
require_relative 'console/filter'
require_relative 'console/hide'

module Wilhelm
  module Virtual
    module Helpers
      # Comment
      module Console
        include Wilhelm::Helpers::Console
        include Filter
        include Hide

        def display_handler
          Handler::DisplayHandler.instance
        end

        alias dh display_handler

        def s
          dh.enable
        end

        def h
          dh.disable
        end

        def apply_debug_defaults
          LOGGER.info(PROC_MOD) { 'Applying console defaults.' }
          shutup!
        end
      end
    end
  end
end
