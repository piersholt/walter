# frozen_string_literal: true

class Wilhelm::Virtual
  class AugmentedGFX < AugmentedDevice
    module State
      # Chianable state commands
      module Chainable
        include Constants
        include Events
        include Observable

        def log_state(delta, level = :debug)
          logger.public_send(level, moi) { delta }
        end

        def monitor_on
          delta = { monitor: ON }
          state!(delta)
          log_state(delta)
          changed
          notify_observers(GFX_MONITOR_ON, device: :gfx)
          self
        end

        def monitor_off
          delta = { monitor: OFF }
          state!(delta)
          log_state(delta)
          changed
          notify_observers(GFX_MONITOR_OFF, device: :gfx)
          self
        end

        # Priority

        def priority_gfx
          # return false if priority?
          # delta = { priority: :gfx }
          # state!(delta)
          # log_state(delta)
          # changed
          # notify_observers(PRIORITY_GFX, device: :gfx)
          self
        end

        def priority_radio
          # return false unless priority?
          # delta = { priority: :rad }
          # state!(delta)
          # log_state(delta)
          # changed
          # notify_observers(PRIORITY_RADIO, device: :gfx)
          self
        end

        # Radio Display

        def radio_display_on
          # return false if radio_overlay?
          # delta = { radio_overlay: ON }
          # state!(delta)
          # log_state(delta)
          # changed
          # notify_observers(PRIORITY_RADIO, device: :gfx)
          self
        end

        def radio_display_off
          # return false unless radio_overlay?
          # delta = { radio_overlay: OFF }
          # state!(delta)
          # log_state(delta)
          # changed
          # notify_observers(PRIORITY_GFX, device: :gfx)
          self
        end

        # Audio OBC

        def audio_obc_on
          # return false if audio_obc?
          # delta = { audio_obc: ON }
          # state!(delta)
          # log_state(delta)
          self
        end

        def audio_obc_off
          # return false unless audio_obc?
          # delta = { audio_obc: OFF }
          # state!(delta)
          # log_state(delta)
          self
        end

        # User Input / Timeout

        def user_input!
          delta = { last_activity: Time.now }
          state!(delta)
          log_state(delta)
          self
        end

        # Readio

        def radio_header(layout)
          raise(ArgumentError, "#{layout} not included in: #{header_layouts.keys}") unless a_header?(layout)
          delta = { radio_display: { header: layout } }
          state!(delta)
          log_state(delta)
        end

        def radio_body(layout)
          raise(ArgumentError, "#{layout} not included in: #{body_layouts.keys}") unless a_body?(layout)
          delta = { radio_display: { body: layout } }
          state!(delta)
          log_state(delta)
        end
      end
    end
  end
end
