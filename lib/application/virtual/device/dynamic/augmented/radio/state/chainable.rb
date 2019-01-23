# frozen_string_literal: true

class Virtual
  class AugmentedRadio < AugmentedDevice
    module State
      # Chianable state commands
      module Chainable
        include Constants
        include Observable
        include Events

        def log_state(delta, level = :debug)
          logger.public_send(level, 'Radio') { "#{delta}" }
        end

        def source_sequence
          @source_sequence ||= SOURCE_SEQUENCE.dup
        end

        # Power

        def on
          state!(power: POWER[ON])
          log_state(power: POWER[ON])
          changed
          notify_observers(GFX_BUSY, device: :rad)
          self
        end

        def off
          state!(power: POWER[OFF])
          log_state(power: POWER[OFF])
          changed
          notify_observers(GFX_IDLE, device: :rad)
          self
        end

        def switch_power
          state!(power: !power)
          log_state(power: !power)
          self
        end

        # Displays

        # Layout/Header
        # def foreground
        #   state!(layout: :on)
        #   log_state(layout: :on)
        #   self
        # end

        def background
          state!(layout: :off)
          log_state(layout: :off)
          self
        end

        def radio_layout
          state!(layout: :radio)
          log_state(layout: :radio)
          changed
          notify_observers(RADIO_LAYOUT_RADIO, device: :rad)
          self
        end

        def tape_layout
          state!(layout: :tape)
          log_state(layout: :tape)
          changed
          notify_observers(RADIO_LAYOUT_TAPE, device: :rad)
          self
        end

        def cdc_layout
          state!(layout: :cdc)
          log_state(layout: :cdc)
          changed
          notify_observers(RADIO_LAYOUT_CDC, device: :rad)
          self
        end

        def digital_layout
          state!(layout: :digital)
          log_state(layout: :digital)
          changed
          notify_observers(RADIO_LAYOUT_DIGITAL, device: :rad)
          self
        end

        def audio_obc_on
          return false if audio_obc?
          state!(audio_obc: ON)
          log_state(audio_obc: ON)
          self
        end

        def audio_obc_off
          return false unless audio_obc?
          state!(audio_obc: OFF)
          log_state(audio_obc: OFF)
          self
        end

        # Menu/Index (body?)
        def body_select
          state!(index: :selection)
          log_state(index: :selection)
          self
        end

        def body_eq
          state!(index: :eq)
          log_state(index: :eq)
          self
        end

        def body_hide
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

        def cycle_source(direction = 1)
          i = source_sequence.index(source)
          return self unless i && on?
          new_mode = source_sequence.rotate!(direction)[i]
          public_send(new_mode)
        end

        def next_source
          cycle_source(1)
        end

        def previous_source
          cycle_source(-1)
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
