# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Comment
      module State
        include Logging

        def change_state(new_state)
          logger.debug(AUDIO) { "State => #{new_state.class}" }
          @state = new_state
          changed
          notify_observers(@state)
          @state
        end

        def enable
          @state.enable(self)
        end

        def disable
          @state.disable(self)
        end

        def on
          @state.on(self)
        end

        # API

        def player?
          player!(player_callback(self))
        end

        def player_callback(context)
          proc do |reply, error|
            begin
              if reply
                logger.info(AUDIO) { "#player_callback(#{reply})" }
                # logger.info(AUDIO) { "reply => #{reply}" }
                context.public_send(reply.name, reply.properties)
              else
                logger.warn(AUDIO) { "Error! (#{error})" }
                # context.offline!
              end
            rescue StandardError => e
              logger.error(AUDIO) { e }
              e.backtrace.each { |line| logger.error(AUDIO) { line } }
              context.change_state(Disabled.new)
            end
          end
        end
      end
    end
  end
end
