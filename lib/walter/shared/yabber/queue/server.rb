# frozen_string_literal: true

# Comment
class Server < MessagingQueue
  extend Forwardable
  # include ThreadSafe

  def_delegators :socket, :recv, :send
  attr_reader :thread

  DEFAULTS = {
    role: :REP,
    protocol: 'tcp',
    address: '*',
    port: '5557'
  }.freeze

  def self.recv
    instance.recv
  rescue ZMQ::Socket => e
    LogActually.messaging.error(self) { "#{e}" }
    e.backtrace.each { |l| LogActually.messaging.error(l) }
    # binding.pry
  end

  # def self.start
  #   instance.start
  # end

  def self.walter
    instance.port = PORT_WALTER_CLIENT_SERVER
    self
  end

  def self.wolfgang
    instance.port = PORT_WOLFGANG_CLIENT_SERVER
    self
  end

  # def self.walter!
  #   return false
  #   walter
  #   # start
  # end
  #
  # def self.wolfgang!
  #   return false
  #   wolfgang
  #   # start
  # end

  # def deserialize(serialized_object)
  #   command = Messaging::Serialized.new(serialized_object).parse
  #   logger.info(self.class) { "Deserialized: #{command}" }
  #   logger.info(self.class) { "name: #{command.name} (#{command.name.class})" }
  #   command
  # end
  #
  # def do_things(i)
  #   logger.debug(self.class) { "#{i}. Wait" }
  #   serialized_object = recv
  #   command = deserialize(serialized_object)
  #   logger.debug(self.class) { "recv => #{command}" }
  #   CommandListener.instance.delegate(command)
  #   # result = send('pong')
  #   # logger.debug(self.class) { "send('pong') => #{result}" }
  # rescue IfYouWantSomethingDone
  #   logger.warn(self.class) { "Chain did not handle! (#{command})" }
  # rescue StandardError => e
  #   logger.error(self.class) { e }
  #   e.backtrace.each { |line| logger.error(self.class) { line } }
  # end
  #
  # def start
  #   logger.debug(self.class) { "#test" }
  #   @thread = Thread.new do
  #     begin
  #       i = 0
  #       logger.debug(self.class) { "enter loop..." }
  #       loop do
  #         do_things(i)
  #         i += 1
  #       end
  #     rescue StandardError => e
  #       logger.fatal(self.class) { e }
  #       e.backtrace { |line| logger.fatal(self.class) { line } }
  #     end
  #     logger.warn(self.class) { 'Test thread ending?' }
  #   end
  # end

  private

  # @override
  def logger
    LogActually.server
  end

  # @pverride
  def open_socket
    LogActually.messaging.debug(self.class) { "Open Socket." }
    LogActually.messaging.debug(self.class) { "Socket: #{Thread.current}" }
    LogActually.messaging.debug(self.class) { "Role: #{role}" }
    LogActually.messaging.debug(self.class) { "URI: #{uri}" }
    # context
    # worker
    context.bind(role, uri)
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

  def payload(message)
    message.to_yaml
  end
end
