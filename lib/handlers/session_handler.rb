require 'singleton'
require 'messages'

class SessionHandler
  include Singleton

  attr_reader :messages

  def self.i
    instance
  end

  def initialize
    @messages = Messages.new
  end

  def inspect
    str_buffer = "<SessionHandler>"
  end

  def add_message(message)
    @messages << message
  end
end
