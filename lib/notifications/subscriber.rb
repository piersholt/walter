# frozen_string_literal: true

require 'rbczmq'

# Comment
class MessagingContext
  include Singleton

  def self.context
    instance.context
  end

  def context
    @context ||= ZMQ::Context.new
  end
end

# Comment
class MessagingQueue
  include Singleton
  attr_writer :role, :protocol, :address, :port

  def destroy
    context.destroy
  end

  def close
    socket.close
    @socket = nil
  end

  def sanitize(string)
    string.to_s
  end

  def self.setup
    instance.setup
    instance
  end

  def setup
    socket
  end

  private

  def context
    @context ||= MessagingContext.context
  end

  def socket
    @socket ||= open_socket
  end

  def role
    @role ||= default_role
  end

  def protocol
    @protocol ||= default_protocol
  end

  def address
    @address ||= default_address
  end

  def port
    @port ||= default_port
  end

  def uri(t_protocol = protocol, t_address = address, t_port = port)
    "#{t_protocol}://#{t_address}:#{t_port}"
  end
end

# Comment
class Subscriber < MessagingQueue
  extend Forwardable

  def_delegators :socket, :recv, :subscribe

  DEFAULTS = {
    role: :SUB,
    protocol: 'tcp',
    address: 'localhost',
    port: '5557'
  }.freeze

  def self.recv
    topic = instance.recv
    payload = instance.recv
    payload
  end

  def self.subscribe(topic = :broadcast)
    instance.subscribe(topic.to_s)
  end

  def self.pi
    instance.port = '5556'
    instance.address = '192.168.1.105'
  end

  # @override
  def setup(topic = :broadcast)
    super()
    topic = sanitize(topic)
    subscribe(topic)
  end

  private

  # @override
  def open_socket
    context.connect(role, uri)
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
