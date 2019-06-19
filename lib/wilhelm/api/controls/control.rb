# frozen_string_literal: true

module Wilhelm
  module API
    class Controls
      # Comment
      class Control
        include Observable

        attr_reader :id, :state, :strategy

        DEFAULT_STRATEGY = TwoStage

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
          raise ArgumentError, "Invalid control state: #{state}" unless
          validate_state(state)
        end

        def validate_state(state)
          %i[press hold release].any? { |s| s == state }
        end
      end
    end
  end
end
