# frozen_string_literal: false

require_relative 'events/interface'
require_relative 'events/receiver'
require_relative 'events/multiplexing'
require_relative 'events/deprecated'
require_relative 'events/application'

module Wilhelm
  module Core
    module Constants
      # Core::Constants::Events
      module Events
        include Interface
        include Receiver
        include Multiplexing
        include Deprecated
        include Application

        ALL_EVENTS = (INTERFACE_EVENTS + RECEIVER_EVENTS + LAYER_EVENTS + USER_EVENTS + APP_EVENTS).freeze

        def event_valid?(event)
          ALL_EVENTS.one? { |e| e == event }
        end

        def validate_event(event)
          raise ::ArgumentError, 'unrecognised action' unless event_valid(event)
        end
      end
    end
  end
end
