# frozen_string_literal: true

# Top level namespace
module Wolfgang
  class Service
    # Wolfgang Service Online State
    class Online
      include LogActually::ErrorOutput
      include Logger

      def manager!(context)
        logger.debug(self.class) { '#manager' }
        context.manager = create_manager(context)
        true
      end

      def audio!(context)
        logger.debug(self.class) { '#audio' }
        context.audio = create_audio(context)
        true
      end

      def notifications!(context)
        logger.debug(self.class) { '#notifications' }
        context.notifications = create_notifications(context)
        true
      end

      def offline!(context)
        context.change_state(Offline.new)
      end

      def alive?(context)
        logger.debug(self.class) { '#alive?' }
        Client.instance.queue_message('ping', alive_block(context))
        true
      end

      private

      def alive_block(context)
        proc do |reply, error|
          begin
            if reply
              logger.debug(self.class) { 'Alive!' }

              Kernel.sleep(30)
              context.alive?
            else
              logger.warn(self.class) { 'Error!' }
              context.offline!
            end
          rescue StandardError => e
            logger.error(self.class) { e }
            e.backtrace.each { |line| logger.error(self.class) { line } }
            context.offline!
          end
        end
      end

      def create_audio(context)
        audio = Audio.new
        audio.on
        audio
      rescue StandardError => e
        with_backtrace(logger, e)
      end

      def create_manager(context)
        manager = Manager.new
        manager.on
        manager
      rescue StandardError => e
        with_backtrace(logger, e)
      end

      def create_notifications(context)
        logger.debug(self.class) { '#create_notifications' }
        notifications = Notifications.new(context)
        # logger.debug(self.class) { '#notifications.start =>' }
        notifications.start
        # logger.debug(self.class) { '#notifications' }
        notifications
      rescue StandardError => e
        with_backtrace(logger, e)
      end

      def open(___)
        logger.debug(self.class) { '#open' }
        false
      end

      def close(context)
        logger.debug(self.class) { '#close' }
        context.change_state(Offline.new)
      end
    end
  end
end
