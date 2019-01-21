# frozen_string_literal: true

class Virtual
  class AugmentedGFX < AugmentedDevice
    module State
      # Comment
      module Model
        include Stateful
        include Constants

        DEFAULT_STATE = {
          source: UNKNOWN,
          priority: UNKNOWN,
          audio_obc: UNKNOWN,
          last_activity: ZERO,
          radio_overlay: UNKNOWN,
          radio_display: {
            header: UNKNOWN,
            body: UNKNOWN
          },
          position: UNKNOWN
        }.freeze

        def default_state
          DEFAULT_STATE.dup
        end

        def source?
          state[:source]
        end

        def priority?
          state[:priority]
        end

        def radio_overlay?
          state[:radio_overlay]
        end

        def audio_obc?
          state[:audio_obc]
        end

        def active?
          Time.now - last_activity <= INPUT_TIMEOUT
        end

        def a_header?(layout)
          header_layouts.include? layout
        end

        def a_body?(layout)
          body_layouts.key?(layout)
        end

        def header_layouts
          DATA_MODEL[:radio_display][:header]
        end

        def body_layouts
          DATA_MODEL[:radio_display][:body]
        end
      end
    end
  end
end
# [overlay] (off) radio relinquishes priority
# [overlay] (on) radio requests priority

# [main menu] (on) gfx takes priority
# [main menu] (off)
