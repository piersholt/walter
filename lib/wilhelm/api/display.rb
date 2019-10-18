# frozen_string_literal: true

puts "\tLoading wilhelm/api/display"

require_relative 'display/states/defaults'
require_relative 'display/states/unknown'
require_relative 'display/states/off'
require_relative 'display/states/enabled'
require_relative 'display/states/busy'
require_relative 'display/states/captured'
require_relative 'display/states/unpowered'

require_relative 'display/handlers/cache_handler'
require_relative 'display/handlers/control_handler'
require_relative 'display/listener'

require_relative 'display/cache'

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
        %i[gt rad bmbt mfl ike]
      end

      # STATES ---------------------------------------------

      def change_state(new_state)
        return false if new_state.class == @state.class
        logger.unknown(self) { "State => #{new_state.class}" }
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

      def aux_request
        @state.aux_request(self)
      end

      def settings_request
        @state.settings_request(self)
      end

      def kl_30
        @state.kl_30(self)
      end

      def kl_r
        @state.kl_r(self)
      end

      def kl_15
        @state.kl_15(self)
      end

      def code_on
        @state.code_on(self)
      end

      def code_off
        @state.code_off(self)
      end

      def prog_on
        @state.prog_on(self)
      end

      def prog_off
        @state.prog_off(self)
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
      DISPLAY_UNPOWERED = 'Unpowered'
      DISPLAY_CODE = 'Code'

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
        when Unpowered
          DISPLAY_UNPOWERED
        when Code
          DISPLAY_CODE
        else
          state.class
        end
      end
    end
  end
end
