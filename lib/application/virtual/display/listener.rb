# have this listen to augmented radio
# don't make radio responsible for notifying of specific events
# just sent state hash and let display listener work it out

class Virtual
  class Display
    module Listener
      include Events
      # @argument: properties
      # - user/device
      # - what they drew?
      def update(event, properties = {})
        case event
        when RADIO_LAYOUT_RADIO
          # LogActually.display.unknown(self.class) { RADIO_LAYOUT_RADIO }
        when RADIO_LAYOUT_CDC
          # LogActually.display.unknown(self.class) { RADIO_LAYOUT_CDC }
        when RADIO_LAYOUT_TAPE
          # LogActually.display.unknown(self.class) { RADIO_LAYOUT_TAPE }
        when RADIO_LAYOUT_DIGITAL
          # LogActually.display.unknown(self.class) { RADIO_LAYOUT_DIGITAL }
        when GFX_MONITOR_ON
          # LogActually.display.unknown(self.class) { GFX_MONITOR_ON }
        when GFX_MONITOR_OFF
          # LogActually.display.unknown(self.class) { GFX_MONITOR_OFF }
        when GFX_IDLE
          # LogActually.display.unknown(self.class) { GFX_IDLE }
          # change_state(Available.new)
        when GFX_BUSY
          # LogActually.display.unknown(self.class) { GFX_BUSY }
          # change_state(Busy.new)
        when DATA_REQUEST
          LogActually.display.unknown(self.class) { "#{DATA_REQUEST}: #{properties}" }
          input_confirm(properties)
        when INPUT_CONFIRM_SELECT
          # LogActually.display.unknown(self.class) { INPUT_CONFIRM_SELECT }
          # input_confirm(properties[:offset])
        when INPUT_CONFIRM_HOLD
          # LogActually.display.unknown(self.class) { INPUT_CONFIRM_HOLD }
        when INPUT_CONFIRM_RELEASE
          # LogActually.display.unknown(self.class) { INPUT_CONFIRM_RELEASE }
        when INPUT_LEFT
          # LogActually.display.unknown(self.class) { INPUT_LEFT }
          # input_left(properties[:value])
        when INPUT_RIGHT
          # LogActually.display.unknown(self.class) { INPUT_RIGHT }
          # input_right(properties[:value])
        when RADIO_BODY_CLEARED
          LogActually.display.unknown(self.class) { RADIO_BODY_CLEARED }
          overwritten!
        end
      end
    end
  end
end

class Virtual
  class Display
    module Handler
      def input_confirm(properties)
        user_input(:select_item, properties)
      end

      def input_left(value)
        # user_input(:input_left, value)
      end

      def input_right(value)
        # user_input(:input_right, value)
      end
    end
  end
end
