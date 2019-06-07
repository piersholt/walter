# frozen_string_literal: true

# Comment
class Publisher < MessagingQueue
  extend Forwardable
  include ManageableThreads
  include ThreadSafe
  include Announce
  extend Announce

  def_delegators :socket, :send, :sendm

  DEFAULTS = {
    role: :PUB,
    protocol: 'tcp',
    address: '*',
    port: '5556'
  }.freeze

  def send!(message)
    queue_message(message)
  end

  def self.send!(message)
    instance.send!(message)
  end

  def self.online(who_am_i)
    instance.online(who_am_i)
  end

  def self.disconnect
    instance.worker.raise(GoHomeNow, 'Disconnect called!')
  end

  def self.destroy
    instance.destroy
  end

  # Publisher.announcement(:walter)
  def self.walter
    instance.port = PORT_WALTER_PUB_SUB
    Publisher.announcement(:walter)
  end

  # Publisher.announcement(:wolfgang)
  def self.wolfgang
    instance.port = PORT_WOLFGANG_PUB_SUB
    Publisher.announcement(:wolfgang)
  end

  private

  # @override
  def logger
    LogActually.publisher
  end

  # @pverride
  def open_socket
    logger.debug(self.class) { "Open Socket." }
    logger.debug(self.class) { "Socket: #{Thread.current}" }
    logger.debug(self.class) { "Role: #{role}" }
    logger.debug(self.class) { "URI: #{uri}" }
    context
    worker
    context.bind(role, uri)
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

  def topic(message)
    message.topic
  end

  def payload(message)
    message.to_yaml
  end
end
