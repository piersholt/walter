require 'singleton'
require 'messages'

# @deprecated updated handler with Messages collection
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
  end

  def inspect
    str_buffer = "<MessageHandler>"
    str_buffer.concat("\nMessages: #{@messages.count}")
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
  #                                  SEARCH
  # ************************************************************************* #

  # @deprecated
  def messages_matching(property, criteria)
    where(property, criteria)
  end

  # TODO: implement a collection class to allow chaining calls
  def where(property, *criteria)
    LOGGER.warn(criteria)
    raise ArgumentError, 'unrecognised property' if SEARCH_PROPERTY.none? { |p| p == property }

    case property
    when :command_id
      messages.find_all do |message|
        c = message.command
        criteria.any? {|crit| crit == c.id[:d] }
        # c.id[:d] == criteria
      end
    when :to_id
      messages.find_all do |message|
        # c = message.command
        r = message.receiver
        r.id[:d] == criteria
      end
    else
      raise StandardError, 'whoops!'
    end
  end

  # ------------------------------ SEARCH: HELPERS ------------------------------ #

  def command(command_id)
    messages = where(:command_id, command_id)
    # messages.map { |m| m.command }
  end

  def to(to_id)
    messages = where(:to_id, to_id)
  end


  # --------------------------- SEARCH: HELPER MACROS --------------------------- #

  def command_to(command_id, to_id)
    everything_send_to_receiver = to(to_id)

    everything_send_to_receiver.find_all do |message|
      c = message.command
      c.id[:d] == command_id
    end
  end

  # ------------------------------ ANALYSIS ------------------------------ #

  def receivers_of_command(command_id)
    matching_messages = where(:command_id, command_id)

    messages_with_unique_recipients =
      matching_messages.uniq do |message|
        message.to.id
      end

    messages_with_unique_recipients.map do |m|
      m.to
    end
  end

  def unique(property, index = 0)
    case property
    when :from
    when :to
    when :command
    when :arguments
      # messages.uniq {|m| m.command.arguments.first.d }
    end
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

  # MessageHandler.instance.f_c(1)
  def f_c(command_id)
    filtered_commands.clear if filtered_commands.size >= 5
    return false if filtered_commands.include?(command_id)
    @filtered_commands << command_id
    true
  end

  # ------------------------------ FILTER: MACRO ------------------------------ #

  # shortcutt for seeing TXT-1 to IKE
  def fct(c = 35, t = 128)
    f_c(c)
    f_t(t)
  end


  # ************************************************************************* #
  #                             CUSTOM QUERIES
  # ************************************************************************* #

  # VERY SPECIFIC METHODS TO LEARN
  def alerts(id = 26)
    begin
      alert_messages = messages_matching(:command_id, id)
      # alert_commands = alert_messages.map { |m| m.command }
      alerts = alert_messages.map do |message|

        from = message.from
        to = message.to
        command = message.command

        # Used to sort array
        mode = command.respond_to?(:mode) ? command.mode : 0
        control = command.respond_to?(:control) ? command.control : 0

        buffer = "#{from.short_name} [#{from.h}] > #{to.short_name} [#{to.h}]\t"

        if command.respond_to?(:mode)
          sub_command = command.arguments.first(2).join(' ')
          buffer = buffer.concat(sub_command)
        end

        [from.d, to.d, mode, control, command, command.arguments.join(' '), buffer]
      end

      alerts.sort! do |a,b|
        a[1] <=> b[1]
      end

      alerts.each do |a|
        print a[-1]
        print " "
        puts a[-2]
        # a[-3].chars.overlay
      end
    rescue StandardError => e
      LOGGER.error("#{e}")
      e.backtrace.each {|l| LOGGER.error("#{l}")}
    end

    return alerts
  end

  def rad(id = 35)
    begin
      alert_messages = messages_matching(:command_id, id)

      alerts = alert_messages.map do |message|
        from = message.from
        to = message.to
        command = message.command

        buffer = "#{from.short_name} [#{from.h}] > #{to.short_name} [#{to.h}] "

        [from.d, to.d, command, command.arguments.join(' '), buffer]
      end

      # Order by receiver
      alerts.sort! do |a,b|
        a[1] <=> b[1]
      end

      alerts.each do |a|
        print a[-1]
        print " "
        puts a[-2]
        # LOGGER.error a[-3].verbose
        puts a[-3].chars.overlay if a[-3].verbose
      end
    rescue StandardError => e
      LOGGER.error("#{e}")
      e.backtrace.each {|l| LOGGER.error("#{l}")}
    end

    return alerts
  end

  private

  # ************************************************************************* #
  #                              OUTPUT FILTERING
  # ************************************************************************* #

  def filtered_output(message)
    x = filtered_commands.one? do |c|
      c == message.command.d
    end

    y = filtered_recipients.one? do |c|
      c == message.to.d
    end

    if x && y
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
