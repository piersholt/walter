# frozen_string_literal: true

module Wilhelm
  module API
    class Controls
      # API::Controls::Control
      class Control
        include Observable

        attr_reader :id, :state, :strategy

        DEFAULT_STRATEGY = TwoStage
        VALID_STATES = %i[press hold release].freeze

        def initialize(id, strategy = DEFAULT_STRATEGY)
          @id = id
          @strategy = strategy.new(name)
        end

        alias button id
        alias control id

        def update(state)
          logger.debug(name) { "#update(#{state})" }
          valid?(state)
          @state = state
          @strategy.notify(self)
        end

        def press?
          @state == :press
        end

        def hold?
          @state == :hold
        end

        def release?
          @state == :release
        end

        def name
          id.upcase
        end

        private

        def logger
          LOGGER
        end

        def valid?(state)
          return true if validate_state(state)
          raise(ArgumentError, "Invalid control state: #{state}")
        end

        def validate_state(state)
          VALID_STATES.any? { |s| s == state }
        end
      end
    end
  end
end
