# A collection class for Message
class Messages
  extend Forwardable

  FORWARD_MESSAGES = %i[<< push first last each empty? size sort_by length to_s count [] find_all find each_with_index find_index map group_by delete_at].freeze
  SEARCH_PROPERTY = [:command_id, :from_id, :to_id].freeze

  FORWARD_MESSAGES.each do |fwrd_message|
    def_delegator :@messages, fwrd_message
  end

  def initialize(messages = [])
    @messages = messages
  end

  def inspect
    str_buffer = "\n"
    result = @messages.map do |m|
      m.inspect
    end.join("\n")

    str_buffer.concat(result)
  end

  # ************************************************************************* #
  #                                  SEARCH
  # ************************************************************************* #

  def command(*command_ids)
    results = where(:command_id, *command_ids)
    self.class.new(results)
  end

  def context(command_id, before = 5, after = 5)
    positions = indexes(command_id)
    positions.map do |index|
      start_position = index - before
      end_position = index + after
      results = @messages[start_position..end_position]
      self.class.new(results)
    end
  end

  def argument(index = 0, *argument_ids)
    raise StandardError if argument_ids.empty?
    results = @messages.find_all do |message|
      arguments = message.command.arguments
      argument_ids.any? { |argument_id| argument_id == arguments[index].d }
    end
    self.class.new(results)
  end

  def to(*to_ids)
    results = where(:to_id, *to_ids)
    self.class.new(results)
  end

  def from(*from_ids)
    results = where(:from_id, *from_ids)
    self.class.new(results)
  end

  # ************************************************************************* #
  #                                  ANALYSIS
  # ************************************************************************* #

  def recipients
    messages_with_unique_recipients = @messages.uniq do |m|
      m.to
    end

    messages_with_unique_recipients.map(&:to)
  end

  def senders
    messages_with_unique_senders = @messages.uniq do |m|
      m.from
    end

    messages_with_unique_senders.map(&:from)
  end

  def commands
    messages_with_unique_commands = @messages.uniq do |m|
      m.command.id
    end

    messages_with_unique_commands.map do |m|
      m.command.h
    end
  end

  def arguments(index = (0..0))
    messages_with_unique_argument_sum = @messages.uniq do |m|
      result = m.command.arguments[index].reduce(0) { |m, arg_byte| m + arg_byte.d }
      result.nil? ? -1 : result
    end

    messages_with_unique_argument_sum.each do |m|
      range = m.command.arguments[index]
      value = (range.nil? || range.empty?) ? ['-1'] : range.map(&:h)
      LOGGER.warn(value)
    end

    argument_values = messages_with_unique_argument_sum.map do |message|
      range = message.command.arguments[index]
      (range.nil? || range.empty?) ? ['-1'] : range.map(&:h)
    end

    argument_values_transposed = argument_values.transpose

    argument_values_transposed.map do |pos|
      pos.uniq
    end

    unique_arguments = messages_with_unique_argument_sum.map do |u_m|
      range = u_m.command.arguments[index]
      (range.nil? || range.empty?) ? ['-1'] : range.map(&:h)
    end

    unique_arguments.delete_if do |argument|
      argument == ['-1']
    end
  end

  def lengths
    message_lengths = @messages.map do |m|
      m.command.arguments.length
    end

    grouped_lengths = message_lengths.group_by { |l| l }

    unique_length_counts = grouped_lengths.map { |l, grp| [l, grp.length] }
    unique_length_counts.to_h
  end

  def group_by_command
    grouped_by_command = @messages.group_by do |message|
      message.command.d
    end

    grouped_by_command.each do |command_id, messages|
      grouped_by_command[command_id] = messages.count
    end

    grouped_by_command
  end

  def group_by_recipient
    grouped_by_recipients = @messages.group_by do |message|
      message.to.d
    end

    grouped_by_recipients.each do |recipient_id, messages|
      grouped_by_recipients[recipient_id] = messages.count
    end

    grouped_by_recipients
  end

  def indexes(command_id)
    positions = []
    @messages.each_with_index do |m, i|
      positions << i if m.command.d == command_id
    end

    positions
  end

  # ************************************************************************* #
  #                                  LAZY SCRIPTS
  # ************************************************************************* #

  def pingers
    command(1).senders
  end

  def pongers
    command(2).senders
  end

  def silent
    ping_recipients = command(1).recipients
    ping_recipients.select do |recipient|
      # recipient_id_decimal = recipient.d
      results = command(2).from(recipient)
      results.nil? || results.empty?
    end
  end

  def alt_pongs
    results = command(2).find_all { |m| m.command.alt? }
    self.class.new(results)
  end

  private

  def where(property, *criteria)
    raise ArgumentError, 'unrecognised property' if SEARCH_PROPERTY.none? { |p| p == property }

    case property
    when :command_id
      @messages.find_all do |message|
        c = message.command
        criteria.any? { |crit| crit == c.d }
      end
    when :to_id
      @messages.find_all do |message|
        # c = message.command
        receiver = message.receiver
        criteria.any? { |crit| crit == receiver }
      end
    when :from_id
      @messages.find_all do |message|
        # c = message.command
        sender = message.sender
        criteria.any? { |crit| crit == sender }
      end
    else
      raise StandardError, 'whoops!'
    end
  end
end
