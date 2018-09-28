require 'singleton'
require 'application/messages'

class MessageHandler
  include Singleton
  # include Event

  SEARCH_PROPERTY = [:command_id, :from_id, :to_id].freeze

  attr_reader :messages

  def self.i
    instance
  end

  def initialize
    @messages = Messages.new
    # filter_commands(17,116)
    show
  end

  def inspect
    str_buffer = "<MessageHandler>"
    str_buffer.concat("\nFilters:")
    str_buffer.concat("\n\tCommands: #{filtered_commands}")
    str_buffer.concat("\n\tTo: #{filtered_recipients}")
  end

  def add_message(message)
    # inspect[MESSAGE_RECEIVED] << message
    @messages << message
    filtered_output(message)
  end

  # ************************************************************************* #
  #                              OUTPUT CONTROL
  # ************************************************************************* #

  def hide
    @output_enabled = false
  end

  def show
    @output_enabled = true
  end

  def output_enabled?
    @output_enabled
  end

  # ************************************************************************* #
  #                              OUTPUT FILTERING
  # ************************************************************************* #

  def clear_filter
    @filtered_commands = populate
    @filtered_recipients = populate
    true
  end

  def f_t(to_id)
    filtered_recipients.clear if filtered_recipients.size >= 5
    return false if filtered_recipients.include?(to_id)
    @filtered_recipients << to_id
    true
  end

  # @alias
  def f_c(*command_ids)
    filter_commands(*command_ids)
  end

  def filter_commands(*command_ids)
    filtered_commands.clear if filtered_commands.size >= 5
    return false if command_ids.any? { |c_id| @filtered_commands.include?(c_id) }
    command_ids.each { |command_id| @filtered_commands << command_id }
    true
  end

  # ------------------------------ FILTER: MACRO ------------------------------ #

  # shortcutt for seeing TXT-1 to IKE
  def fct(c = 35, t = 128)
    f_c(c)
    f_t(t)
  end

  def self.fc(*c_d)
    c_d.each { |c_d| i.f_c(c_d) }
  end

  private

  # ************************************************************************* #
  #                              OUTPUT FILTERING
  # ************************************************************************* #

  def filtered_output(message)
    matches_a_command = filtered_commands.one? do |c|
      c == message.command.d
    end

    matches_a_recipient = filtered_recipients.one? do |c|
      c == message.to.d
    end

    return false unless output_enabled?

    if matches_a_command && matches_a_recipient
      LOGGER.info(message)
      return true
    else
      return false
    end
  end

  def filtered_commands
    @filtered_commands ||= populate
  end

  def filtered_recipients
    @filtered_recipients ||= populate
  end

  def populate
    Array.new(256) { |i| i }
  end
end
