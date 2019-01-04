# frozen_string_literal: true

class Virtual
  class AugmentedRadio < AugmentedDevice
    module State
      # Chianable state commands
      module Chainable
        include Constants

        def log_state(delta, level = :info)
          logger.public_send(level, 'Radio') { "#{delta}" }
        end

        def source_sequence
          @source_sequence ||= SOURCE_SEQUENCE.dup
        end

        # Power

        def on
          state!(power: POWER[ON])
          log_state(power: POWER[ON])
          self
        end

        def off
          state!(power: POWER[OFF])
          log_state(power: POWER[OFF])
          self
        end

        def switch_power
          state!(power: !power)
          log_state(power: !power)
          self
        end

        # Displays

        def foreground
          state!(header: :on)
          log_state(header: :on)
          self
        end

        def background
          state!(header: :off)
          log_state(header: :off)
          self
        end

        def selection
          state!(index: :selection)
          log_state(index: :selection)
          self
        end

        def eq
          state!(index: :eq)
          log_state(index: :eq)
          self
        end

        def hide
          state!(index: :hidden)
          log_state(index: :hidden)
          self
        end

        # Source

        def radio
          state!(source: SOURCE[RADIO])
          log_state(source: SOURCE[RADIO])
          self
        end

        def cdc
          state!(source: SOURCE[CDC])
          log_state(source: SOURCE[CDC])
          self
        end

        def tv
          state!(source: SOURCE[TV])
          log_state(source: SOURCE[TV])
          self
        end

        def tape
          state!(source: SOURCE[TAPE])
          log_state(source: SOURCE[TAPE])
          self
        end

        def external
          state!(source: SOURCE[EXTERNAL])
          log_state(source: SOURCE[EXTERNAL])
          self
        end

        def next_source
          i = source_sequence.index(source)
          return self unless i && on?
          new_mode = source_sequence.rotate!(1)[i]
          public_send(new_mode)
          # state!(source: new_mode)
          # log_state(source: new_mode)
          # self
        end

        def previous_source
          i = source_sequence.index(source)
          return self unless i && on?
          new_mode = source_sequence.rotate!(-1)[i]
          public_send(new_mode)
          # state!(source: new_mode)
          # log_state(source: new_mode)
          # self
        end

        # Dependencies

        def depend(ident)
          log_state(dependencies)
          return self if dependencies.include?(ident)
          state!(dependencies: (dependencies << ident))
          log_state(dependencies: dependencies)
          self
        end

        # Seen

        def seen
          state!(last_pong: Time.now)
          log_state(last_pong: Time.now)
          self
        end
      end
    end
  end
end
