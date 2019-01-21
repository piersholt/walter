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
          LogActually.display.debug(self.class) { RADIO_LAYOUT_RADIO }
        when RADIO_LAYOUT_CDC
          LogActually.display.debug(self.class) { RADIO_LAYOUT_CDC }
        when RADIO_LAYOUT_TAPE
          LogActually.display.debug(self.class) { RADIO_LAYOUT_TAPE }
        end
      end
    end
  end
end

class Virtual
  class Display
    module Handler
      #
    end
  end
end
