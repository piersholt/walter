# frozen_string_literal: true

# Top level namespace
module Wolfgang
  class Service
    # Wolfgang Service Online State
    class Online
      include LogActually::ErrorOutput
      include Logger

      def open(___)
        logger.debug(WOLFGANG_ONLINE) { '#open' }
        false
      end

      def close(context)
        logger.debug(WOLFGANG_ONLINE) { '#close' }
        logger.debug(WOLFGANG_ONLINE) { 'Stop Notifications' }
        context.notifications&.stop
        logger.debug(WOLFGANG_ONLINE) { 'Disable Mananger' }
        context.manager&.disable
        logger.debug(WOLFGANG_ONLINE) { 'Disable Audio' }
        context.audio&.disable
        logger.debug(WOLFGANG_ONLINE) { 'Disconnect Client.' }
        Client.disconnect
        logger.debug(WOLFGANG_ONLINE) { 'Disconnect Publisher.' }
        Publisher.disconnect
        # logger.debug(WOLFGANG_ONLINE) { 'Destroy context.' }
        # Publisher.destroy
        context.offline!
      end

      def manager!(context)
        logger.debug(WOLFGANG_ONLINE) { '#manager' }
        context.manager = create_manager(context)
        true
      end

      def audio!(context)
        logger.debug(WOLFGANG_ONLINE) { '#audio' }
        context.audio = create_audio(context)
        true
      end

      def notifications!(context)
        logger.debug(WOLFGANG_ONLINE) { '#notifications' }
        context.notifications = create_notifications(context)
        true
      end

      def offline!(context)
        context.change_state(Offline.new)
      end

      def establishing!(context)
        context.change_state(Establishing.new)
      end

      def alive?(context)
        LogActually.alive.debug(WOLFGANG_ONLINE) { '#alive?' }
        # Client.instance.queue_message('ping', )
        context.ping!(alive_block(context))
        true
      end

      private

      def alive_block(context)
        proc do |reply, error|
          begin
            if reply
              LogActually.alive.debug(WOLFGANG_ONLINE) { 'Alive!' }

              Thread.new(context) do |thread_context|
                begin
                  Kernel.sleep(30)
                  thread_context.alive?
                rescue StandardError => e
                  LogActually.alive.error(WOLFGANG_ONLINE) { e }
                  e.backtrace.each { |line| LogActually.alive.error(WOLFGANG_ONLINE) { line } }
                end
              end
            elsif error == :timeout
              LogActually.alive.warn(WOLFGANG_ONLINE) { "Timeout!" }
              context.establishing!
            elsif error == :down
              LogActually.alive.warn(WOLFGANG_ONLINE) { "Error!" }
              context.offline!
            end
          rescue MessagingQueue::GoHomeNow => e
            # LogActually.alive.fatal(WOLFGANG_ONLINE) { 'Doing many, many important things!' }
            # with_backtrace(LogActually.alive., e)
            # LogActually.alive.fatal(WOLFGANG_ONLINE) { 'Okay bye now!' }
            raise e
          rescue StandardError => e
            LogActually.alive.error(WOLFGANG_ONLINE) { 'FYI: You\'re in Wolfgang::Online!' }
            LogActually.alive.error(WOLFGANG_ONLINE) { e }
            e.backtrace.each { |line| LogActually.alive.error(WOLFGANG_ONLINE) { line } }
            context.offline!
          end
        end
      end

      def create_audio(context)
        audio = Audio.new
        audio.enable
        audio
      rescue StandardError => e
        with_backtrace(logger, e)
        :error
      end

      def create_manager(context)
        manager = Manager.new
        manager.enable
        manager
      rescue StandardError => e
        with_backtrace(logger, e)
        :error
      end

      def create_notifications(context)
        logger.debug(WOLFGANG_ONLINE) { '#create_notifications' }
        notifications = Notifications.new(context)
        # logger.debug(WOLFGANG_ONLINE) { '#notifications.start =>' }
        notifications.start
        # logger.debug(WOLFGANG_ONLINE) { '#notifications' }
        notifications
      rescue StandardError => e
        with_backtrace(logger, e)
      end
    end
  end
end
