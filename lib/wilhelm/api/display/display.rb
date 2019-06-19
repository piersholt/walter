# Okay, a thing that listens to certain devices that affect it...

module Wilhelm
  module API
    # This class handles the re-draw
    # The states will determine this automatically
    # When busy, it will not draw
    # When active, will listen for overwrite vents, which will re-draw
    class Display
      include Singleton
      include Listener
      include CacheHandler
      include InputHandler

      TIMEOUT = 5

      attr_accessor :bus, :menu, :header, :notification_header, :default_header
      attr_reader :state
      alias view menu

      def initialize
        # @state = Available.new
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
      end

      def online!
        @state.online!(self)
      end

      # RENDER ------------------------------------------------

      def render_header(view)
        @state.render_header(self, view)
      end

      def render_new_header(view)
        @state.render_new_header(self, view)
      end

      def dismiss(view)
        @state.dismiss(self, view)
      end

      def render_menu(view)
        @state.render_menu(self, view)
      end

      # EVENTS ------------------------------------------------

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

      def input_menu
        @state.input_menu(self)
      end

      def input_aux_heat
        # LOGGER.unknown(self) { '#input_aux_heat' }
        @state.input_aux_heat(self)
      end

      def overwritten!
        @state.overwritten!(self)
      end

      def overwritten_header!
        @state.overwritten_header!(self)
      end

      # Basically discard in all states but InUse/Walter
      def user_input(method, properties = {})
        @state.user_input(self, method, properties)
      end

      # HELPERS ----------------------------------------------------

      def logger
        LOGGER
      end

      def timeout
        TIMEOUT
      end

      def resume
        bus.rad.render(0x62)
        bus.rad.render(view.layout)
      end

      def cache
        @cache ||= Cache.new
      end

      def to_s
        "Display (#{state_string})"
      end

      def state_string
        case state
        when Unknown
          'Unknown'
        when Enabled
          'Enabled'
        when Disabled
          'Disabled'
        when Busy
          'Busy'
        when Captured
          'Captured'
        when Overwritten
          'Overwritten'
        else
          state.class
        end
      end
    end
  end
end
