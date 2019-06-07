# frozen_string_literal: true

# Comment
class Client < MessagingQueue
  extend Forwardable
  include ThreadSafe

  def_delegators :socket, :send, :recv

  DEFAULTS = {
    role: :REQ,
    protocol: 'tcp',
    address: 'localhost',
    port: '5557'
  }.freeze

  def self.pi
    instance.address = ADDRESS_PI
    print_configuration
    self
  end

  def self.mbp
    instance.address = ADDRESS_MBP
    print_configuration
    self
  end

  def self.walter
    instance.port = PORT_WALTER_CLIENT_SERVER
    print_configuration
    self
  end

  def self.wolfgang
    instance.port = PORT_WOLFGANG_CLIENT_SERVER
    print_configuration
    self
  end

  def self.disconnect
    instance.worker.raise(GoHomeNow, 'Disconnect called!')
  end

  def self.destroy
    instance.destroy
  end

  # @override ThreadSafe#queue_message
  def queue_message(request, callback)
    logger.debug('Client#queue_message') { 'Queue Message' }
    logger.debug('Client#queue_message') { "Queued Message: #{request}" }
    queue.push(request: request, callback: callback)
    true
  rescue StandardError => e
    with_backtrace(logger, e)
    false
  end

  # @override
  def logger
    LogActually.client
  end

  private

  # @override ThreadSafe#pop
  def pop(i, thread_queue)
    logger.debug(self.class) { "Worker waiting (Next: Message ID: #{i})" }
    popped_request = thread_queue.pop

    req = popped_request[:request]
    popped_request[:request] = req.to_yaml

    logger.debug(self.class) { "Message ID: #{i} => #{popped_request}" }
    popped_request

    # logger.debug(self.class) { "Message ID: #{i} => #{popped_messsage}" }
    # popped_messsage
  rescue GoHomeNow => e
    raise e
  rescue StandardError => e
    with_backtrace(logger, e)
  end

  # @override ThreadSafe#worker_process
  def worker_process(thread_queue)
    logger.debug(self.class) { "#worker_process (#{Thread.current})" }
    i = 1
    loop do
      string_hash = pop(i, thread_queue)
      # logger.debug(self.class) { "string_hash => #{string_hash}" }
      forward_to_zeromq(string_hash[:request], &string_hash[:callback])
      i += 1
      # Kernel.sleep(3)
    end
  rescue GoHomeNow => e
    logger.debug(self.class) { "#{e.class}: #{e.message}" }
    result = disconnect
    logger.debug(self.class) { "#disconnect => #{result}" }
    # with_backtrace(logger, e)
    # logger.fatal(self.class) { 'Okay byyyeeeee!' }
  end

  def deserialize(serialized_object)
    logger.debug(self.class) { "#deserialize(#{serialized_object})" }
    command = Messaging::Serialized.new(serialized_object).parse
    logger.debug(self.class) { "Deserialized: #{command}" }
    logger.debug(self.class) { "name: #{command.name} (#{command.name.class})" }
    command
  end

  # def send_tha_thing(i, string)
  #   logger.debug(self.class) { "Attempt: #{i}" }
  #   result = socket.send(string)
  #   logger.debug(self.class) { "send(#{string}) => #{result}" }
  #   raise StandardError, 'message failed to send...' unless result
  # end

  # @override ThreadSafe#forward_to_zeromq
  def forward_to_zeromq(string, &callback)
    timeout = 10
    logger.debug(self.class) { "#forward_to_zeromq(#{string})" }
    3.times do |i|
      result = socket.send(string)
      logger.debug(self.class) { "send(#{string}) => #{result}" }
      raise StandardError, 'message failed to send...' unless result
      logger.debug(self.class) { "#select([socket], nil, nil, #{timeout})" }
      if select([socket], nil, nil, timeout)
        serialized_reply = socket.recv
        logger.debug(self.class) { "serialized_reply => #{serialized_reply}" }
        reply = deserialize(serialized_reply)
        logger.debug(self.class) { "reply => #{reply}" }
        yield(reply, nil)
        return true
      else
        yield(reply, :timeout)
        logger.warn(self.class) { 'Timeout! Retry!' }
        close
        socket
        timeout *= 2
      end
      logger.warn(self.class) { 'Down?' }
    end

    # raise StandardError, 'server down?'
    yield(nil, :down)

    # reply = recv
    # LogActually.messaging.debug(self.class) { "reply => #{reply}" }
    # callback.call(reply)
    # raise StandardError, 'Failed send?' unless result_topic && result_payload
    # self.counter = counter + 1
  end

  # @override ZMQ.select due to what I think is odd IO.select behaviour
  def select(read = [], write = [], error = [], timeout = nil)
    poller = ZMQ::Poller.new
    read&.each { |s| poller.register_readable(s) }
    write&.each { |s| poller.register_writable(s) }
    ready = poller.poll(timeout)
    logger.debug(self.class) { "ready => #{ready}" }
    logger.debug(self.class) { "ready ? true : false => #{ready ? true : false}" }
    case ready
    when 1
      [poller.readables, poller.writables, []] if ready
    when 0
      false
    end
  end

  # @pverride MessagingQueue#open_socket
  def open_socket
    LogActually.messaging.info(self.class) { 'Open Socket.' }
    LogActually.messaging.debug(self.class) { "Socket: #{Thread.current}" }
    LogActually.messaging.debug(self.class) { "Role: #{role}" }
    LogActually.messaging.debug(self.class) { "URI: #{uri}" }
    context
    # binding.pry
    queue
    # worker
    connect
  end

  def connect
    LogActually.messaging.debug(self.class) { '#connect' }
    result = context.connect(role, uri)
    LogActually.messaging.debug(self.class) { "socket.connect => #{result}" }
    result
  end

  def disconnect
    logger.debug(self.class) { '#disconnect' }
    result = socket.disconnect(uri)
    logger.debug(self.class) { "socket.disconnect => #{result}" }
    result
  end

  def default_role
    DEFAULTS[:role]
  end

  def default_protocol
    DEFAULTS[:protocol]
  end

  def default_address
    DEFAULTS[:address]
  end

  def default_port
    DEFAULTS[:port]
  end
end
