class MessagingQueue
  module Announce
    include Messaging::Constants
    include ManageableThreads
    def announcement(announcer)
      @node = announcer
      # logger.debug('Announce') { "Spawn Thread" }
      @announce = Thread.new(announcer) do |announcer|
        # logger.debug('Announce') { "Thead new" }
        begin
          # logger.debug('Announce') { "Start" }
          3.times do
            announce(announcer)
            Kernel.sleep(1)
            # logger.debug('Announce') { "announce #{i}" }
          end
          # logger.debug('Announce') { 'Finish' }
        rescue StandardError => e
          with_backtrace(logger, e)
        end
        logger.debug(self.class) { "Annoucement complete!" }
      end
      # logger.debug('Announce') { "Spawned Thread" }
      add_thread(@announce)
    end

    def announce(announcer)
      n = Messaging::Notification.new(node: announcer, topic: CONTROL, name: :announcement)
      LogActually.messaging.debug(self.class) { "Publisher Ready Send." }
      Publisher.send!(n)
    end

    def self.announce
      instance.announce(announcer)
    end

    def self.announement
      instance.announement(announcer)
    end
  end
end
