# Okay, a thing that listens to certain devices that affect it...

class Virtual
  # This class handles the re-draw
  # The states will determine this automatically
  # When busy, it will not draw
  # When active, will listen for overwrite vents, which will re-draw
  class Display
    include Singleton
    include Listener
    include Handler

    TIMEOUT = 5

    attr_accessor :bus, :menu, :header, :notification_header, :default_header
    attr_reader :state
    alias view menu

    def initialize
      # @state = Available.new
      @state = Available.new
    end

    def timeout
      TIMEOUT
    end

    def resume
      bus.rad.render(0x62)
      bus.rad.render(view.layout)
    end

    def overwritten!
      @state.overwritten!(self)
    end

    def change_state(new_state)
      return false if new_state.class == @state.class
      logger.debug(self.class) { "state change => #{new_state.class}" }
      @state = new_state
    end

    # HEADER --------------------------------------------

    def render_header(view)
      @state.render_header(self, view)
    end

    def render_new_header(view)
      @state.render_new_header(self, view)
    end

    def dismiss(view)
      @state.dismiss(self, view)
    end

    # MENU --------------------------------------------

    def render_menu(view)
      @state.render_menu(self, view)
    end

    # EVENTS --------------------------------------------

    # Basically discard in all states but InUse/Walter
    def user_input(method, properties = {})
      @state.user_input(self, method, properties)
    end

    # new layout to
    # def create(laytout)
    #   @state.open(self)
    # end

    # def update(laytout)
    # end

    # redraw cached laytout
    def refresh; end

    # Release control of display back to vehicle
    def release; end


    def logger
      LogActually.display
    end
  end
end
