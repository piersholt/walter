# Okay, a thing that listens to certain devices that affect it...

class Vehicle
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

    # STATES ---------------------------------------------

    def change_state(new_state)
      return false if new_state.class == @state.class
      logger.info(self) { "state change => #{new_state.class}" }
      @state = new_state
    end

    def online!
      @state.online!(self)
    end

    # HEADER ------------------------------------------------

    def render_header(view)
      @state.render_header(self, view)
    end

    def render_new_header(view)
      @state.render_new_header(self, view)
    end

    def dismiss(view)
      @state.dismiss(self, view)
    end

    # MENU ----------------------------------------------------

    def render_menu(view)
      @state.render_menu(self, view)
    end

    # EVENTS ------------------------------------------------

    # def enabled
    #   @state.enabled(self)
    # end
    #
    # def disabled
    #   @state.disabled(self)
    # end

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
      # LogActually.display.unknown(self) { '#obc_request' }
      @state.obc_request(self)
    end

    def input_menu
      # LogActually.display.unknown(self) { '#input_menu' }
      @state.input_menu(self)
    end

    def input_aux_heat
      LogActually.display.unknown(self) { '#input_aux_heat' }
      @state.input_aux_heat(self)
    end

    def overwritten!
      @state.overwritten!(self)
    end

    # Basically discard in all states but InUse/Walter
    def user_input(method, properties = {})
      @state.user_input(self, method, properties)
    end

    # HELPERS ----------------------------------------------------

    def logger
      LogActually.display
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
