class MessagingQueue
  module ThreadSafe
    include ManageableThreads
    QUEUE_SIZE = 32

    def self.semaphore
      instance.semaphore
    end

    def semaphore
      @semaphore ||= Mutex.new
    end

    # def context
      # semaphore.synchronize do
        # @context ||= create_context
      # end
    # end

    def queue_message(message)
      logger.debug('ThreadSafe#queue_message') { "Queue Message" }
      logger.debug('ThreadSafe#queue_message') { "Queued Message: #{message}" }
      queue.push(message)
      true
    rescue StandardError => e
      with_backtrace(logger, e)
      false
    end

    def queue
      Mutex.new.synchronize do
        logger.debug(self.class) { "#queue [Thread: #{Thread.current}]" }
        @queue ||= create_queue
      end
    end

    def worker
      semaphore.synchronize do
        @worker ||= create_worker
      end
    end

    def fuck_off?
      @fuck_off ||= false
    end

    def fuck_off!
      @fuck_off = true
    end

    def worker_process(thread_queue)
      logger.debug(self.class) { "#worker_process (#{Thread.current})" }
      i = 1
      loop do
        message_hash = pop(i, thread_queue)
        forward_to_zeromq(message_hash[:topic], message_hash[:payload])
        i += 1
        # Kernel.sleep(3)
      end
    rescue MessagingQueue::Errors::GoHomeNow => e
      logger.debug(self.class) { "#{e.class}: #{e.message}" }
      result = disconnect
      logger.debug(self.class) { "#disconnect => #{result}" }
      # with_backtrace(logger, e)
      # logger.fatal(self.class) { 'Okay byyyeeeee!' }
    end

    def create_queue
      logger.debug(self.class) { 'Create Queue' }
      new_queue = SizedQueue.new(QUEUE_SIZE)
      create_worker(new_queue)
      new_queue
    rescue StandardError => e
      with_backtrace(logger, e)
    end

    def create_worker(existing_queue = nil)
      return false if fuck_off?
      logger.debug(self.class) { 'Create Worker' }
      q = existing_queue ? existing_queue : queue
      @worker = create_worker_thread(q)
      add_thread(@worker)
      fuck_off!
    end

    def create_worker_thread(q)
      # TODO: Idiot...
      # Mutex.new.synchronize do
        Thread.new(q) do |thread_queue|
          logger.debug(self.class) { "Worker: #{Thread.current}" }
          Thread.current[:name] = 'Publisher Worker'
          begin
            logger.debug(self.class) { 'Worker starting...' }
            worker_process(thread_queue)
            logger.debug(self.class) { 'Worker ended...!' }
          rescue StandardError => e
            logger.error(self.class) { e }
            e.backtrace.each do |line|
              logger.error(self.class) { line }
            end
          end
        end
      # end
    end

    def pop(i, thread_queue)
      logger.debug(self.class) { "Worker waiting (Next: Message ID: #{i})" }
      popped_messsage = thread_queue.pop
      popped_messsage.id = i
      popped_messsage.session = Time.now.strftime("%j_%H_%M")
      message_hash = { topic: topic(popped_messsage),
                       payload: payload(popped_messsage) }

      logger.debug(self.class) { "Message ID: #{i} => #{message_hash}" }
      message_hash
    rescue IfYouWantSomethingDone
      logger.warn(self.class) { 'Chain did not handle!' }
    rescue MessagingQueue::Errors::GoHomeNow => e
      raise e
    rescue StandardError => e
      with_backtrace(logger, e)
    end

    def forward_to_zeromq(topic, payload)
      logger.debug(self.class) { "Worker: #{Thread.current}" }
      topic = sanitize(topic)
      payload = sanitize(payload)
      # logger.debug(counter)

      result_topic = sendm(topic)
      result_payload = send(payload)
      logger.debug(topic)
      logger.debug(payload)
      raise StandardError, 'Failed send?' unless result_topic && result_payload
      # self.counter = counter + 1
    end
  end
end
