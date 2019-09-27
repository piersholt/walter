# frozen_string_literal: true

module Wilhelm
  module API
    # This class handles the re-draw
    # The states will determine this automatically
    # When busy, it will not draw
    # When active, will listen for overwrite vents, which will re-draw
    class Display
      include Singleton
      include Helpers::Observation
      include Listener
      include CacheHandler
      include ControlHandler

      attr_accessor :bus, :menu, :header, :notification_header, :default_header
      attr_reader :state
      alias view menu

      def initialize
        @state = Unknown.new
      end

      # Walter Virtual

      def targets
        %i[gfx rad bmbt mfl]
      end

      # STATES ---------------------------------------------

      def change_state(new_state)
        return false if new_state.class == @state.class
        logger.debug(self) { "State => #{new_state.class}" }
        @state = new_state
        changed
        notify_observers(state)
      end

      def online!
        @state.online!(self)
      end

      # RENDER ------------------------------------------------

      def render_header(view)
        @state.render_header(self, view)
      end

      def render_menu(view)
        @state.render_menu(self, view)
      end

      def update_menu(view)
        @state.update_menu(self, view)
      end

      # EVENTS ------------------------------------------------

      # Events: State
      def ping
        @state.ping(self)
      end

      def announce
        @state.announce(self)
      end

      def monitor_on
        @state.monitor_on(self)
      end

      def monitor_off
        @state.monitor_off(self)
      end

      def obc_request
        @state.obc_request(self)
      end

      # Events: Control
      def input_menu
        @state.input_menu(self)
      end

      def user_input(method, properties = {})
        @state.user_input(self, method, properties)
      end

      # HELPERS ----------------------------------------------------

      def logger
        LOGGER
      end

      def cache
        @cache ||= Cache.new
      end

      def to_s
        "Display (#{state_string})"
      end

      DISPLAY_UNKNOWN = 'Unknown'
      DISPLAY_ENABLED = 'Enabled'
      DISPLAY_DISABLED = 'Off'
      DISPLAY_BUSY = 'Busy'
      DISPLAY_CAPTURED = 'Captured'

      # @todo a Hash would be more efficient
      def state_string
        case state
        when Unknown
          DISPLAY_UNKNOWN
        when Enabled
          DISPLAY_ENABLED
        when Off
          DISPLAY_DISABLED
        when Busy
          DISPLAY_BUSY
        when Captured
          DISPLAY_CAPTURED
        else
          state.class
        end
      end
    end
  end
end
