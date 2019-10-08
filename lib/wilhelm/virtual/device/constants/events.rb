# frozen_string_literal: true

puts "\tLoading wilhelm/virtual/device/constants/events"

require_relative 'events/bmbt'
require_relative 'events/cluster'
require_relative 'events/display'
require_relative 'events/lcm'
require_relative 'events/mfl'
require_relative 'events/radio'
require_relative 'events/tel'

module Wilhelm
  module Virtual
    module Constants
      # Virtual::Constants::Events
      module Events
        # Action
        module Action
          include Telephone::Action

          ACTIONS = constants.map { |c| const_get(c) }
        end
        # Cache
        module Cache
          include Display::Cache

          CACHES = constants.map { |c| const_get(c) }
        end

        # Control
        module Control
          include BMBT::Control
          include Cluster::Control
          include Display::Control
          include MFL::Control
          include Radio::Control
          include Telephone::Control

          CONTROLS = constants.map { |c| const_get(c) }
        end

        # State
        module State
          include Cluster::State
          include Display::State
          include LCM::State
          include Radio::State

          STATES = constants.map { |c| const_get(c) }
        end

        include Action
        include Cache
        include Control
        include State

        def action?(event)
          ACTIONS.include?(event)
        end

        def cache?(event)
          CACHES.include?(event)
        end

        def control?(event)
          CONTROLS.include?(event)
        end

        def state?(event)
          STATES.include?(event)
        end
      end
    end
  end
end
