# frozen_string_literal: true

class MessagingBus
  PROC = 'STDOUT'
  OUTPUT_FORMAT = :to_yaml

  def publish(message)
    m = formatted_message(message)
    LOGGER.info(PROC) { m }
    STDOUT.write(m)
  end

  def close(reason = '')
    return false
  end

  def formatted_message(m)
    m.send(OUTPUT_FORMAT)
  end
end

require 'rbczmq'

# Implementation of MessagingBus
class ZeroMQBus < MessagingBus
  attr_accessor :role, :context
  PROC = 'ZeroMQ'
  ROLE = :PUB
  BIND_ADDRESS = 'tcp://*:5556'
  OUTPUT_FORMAT = :to_yaml

  def server
    @server ||= open
  end

  def initialize(role = ROLE)
    @role = role
  end

  def open
    @context = MessagingContext.context
    @context.bind(ROLE, BIND_ADDRESS)
  end

  def close(message)
    publish(message)
    server.close
    context.destroy
  end

  def publish(message)
    m = formatted_message(message)
    LOGGER.info(PROC) { m }
    server.send(m)
  end
end
