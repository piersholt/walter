# frozen_string_literal: true

class Wilhelm::Virtual
  class AugmentedGFX < AugmentedDevice
    module State
      # Comment
      module Model
        include Stateful
        include Constants

        DEFAULT_STATE = {
          monitor: ON
          # source: GFX,
          # TODO: priority this needs to be 'radio_mode:'
          # there's no need to have radio_overlay and this..
          # priority: UNKNOWN,
          # fuck this off
          # audio_obc: OFF,
          # fuck this off
          # last_activity: ZERO,
          # radio_overlay: UNKNOWN,
          # radio_display: {
          #   header: UNKNOWN,
          #   body: UNKNOWN
          # },
        }.freeze

        def default_state
          DEFAULT_STATE.dup
        end

        def monitor?
          state[:monitor]
        end

        def source?
          state[:source]
        end

        def priority?
          LogActually.gfx.warn('AugmentedGFX') { '#priority is deprecated!' }
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
          HEADERS_VALID.include?(layout)
        end

        def a_body?(layout)
          MENUS_VALID.key?(layout)
        end

        # def header_layouts
        #   DATA_MODEL[:radio_display][:header]
        # end

        # def body_layouts
        #   DATA_MODEL[:radio_display][:body]
        # end
      end
    end
  end
end
# [overlay] (off) radio relinquishes priority
# [overlay] (on) radio requests priority

# [main menu] (on) gfx takes priority
# [main menu] (off)
