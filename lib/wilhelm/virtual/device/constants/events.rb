# frozen_string_literal: true

puts "\tLoading wilhelm/virtual/device/constants/events"

require_relative 'events/bmbt'
require_relative 'events/display'
require_relative 'events/mfl'
require_relative 'events/radio'

module Wilhelm
  module Virtual
    module Constants
      # Virtual::Constants::Events
      module Events
        # Cache
        module Cache
          include Display::Cache

          CACHES = constants.map { |c| const_get(c) }
        end

        # State
        module State
          include Display::State
          include Radio::State

          STATES = constants.map { |c| const_get(c) }
        end

        # Input
        module Input
          include BMBT::Input
          include Display::Input
          include MFL::Input

          INPUTS = constants.map { |c| const_get(c) }
        end

        def cache?(event)
          CACHES.include?(event)
        end

        def input?(event)
          INPUTS.include?(event)
        end

        def state?(event)
          STATES.include?(event)
        end
      end
    end
  end
end
