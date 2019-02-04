module Wolfgang
  class Audio
    class Enabled
      include Logger

      def initialize(context)
        logger.debug(AUDIO_ENABLED) { '#initialize' }
        # Build state
        # context.device_list
      end


      # STATES --------------------------------------------------

      def disable(context)
        context.change_state(Disabled.new)
      end
    end
  end
end
