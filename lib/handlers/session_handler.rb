require 'singleton'
require 'messages'

class SessionHandler
  include Singleton
  # include Event

  SEARCH_PROPERTY = [:command_id, :from_id, :to_id].freeze

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
