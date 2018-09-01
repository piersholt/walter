# A collection class for Message
class Messages
  extend Forwardable

  FORWARD_MESSAGES = %i[<< push first last each empty? size length to_s count [] find_all find find_index map group_by].freeze
  SEARCH_PROPERTY = [:command_id, :from_id, :to_id].freeze

  FORWARD_MESSAGES.each do |fwrd_message|
    def_delegator :@messages, fwrd_message
  end

  def initialize(messages = [])
    @messages = messages
  end

  def inspect
    @messages.join("\n")
  end
  #
  # def to_s
  #   "<Messages>#to_s"
  # end

  # ************************************************************************* #
  #                                  SEARCH
  # ************************************************************************* #

  def command(*command_ids)
    results = where(:command_id, *command_ids)
    self.class.new(results)
  end

  def argument(index = 0, *argument_ids)
    raise StandardError if argument_ids.empty?
    results = @messages.find_all do |message|
      arguments = message.command.arguments
      argument_ids.any? { |argument_id| argument_id == arguments[index].d }
    end
    self.class.new(results)
  end

  def to(to_id)
    results = where(:to_id, to_id)
    self.class.new(results)
  end

  def from(from_id)
    results = where(:from_id, from_id)
    self.class.new(results)
  end

  # ---------------------------- SEARCH: HELPERS ---------------------------- #

  # @deprecated in favour of chained collection methods
  # def command_to(command_id, to_id)
  #   everything_send_to_receiver = to(to_id)
  #
  #   everything_send_to_receiver.find_all do |message|
  #     c = message.command
  #     c.id[:d] == command_id
  #   end
  # end

  # ************************************************************************* #
  #                                  ANALYSIS
  # ************************************************************************* #

  # @deprecated in favour of #recipients which is called directly on collection
  # def receivers_of_command(command_id)
  #   matching_messages = where(:command_id, command_id)
  #
  #   messages_with_unique_recipients =
  #     matching_messages.uniq do |message|
  #       message.to.id
  #     end
  #
  #   messages_with_unique_recipients.map(&:to)
  # end

  def recipients
    messages_with_unique_recipients = @messages.uniq do |m|
      m.to.id
    end

    messages_with_unique_recipients.map(&:to)
  end

  def senders
    messages_with_unique_senders = @messages.uniq do |m|
      m.from.id
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

  # @note this only gathers unique based on first byte in arguments
  # def arguments
  #   messages_with_unique_arguments = @messages.uniq do |m|
  #     m.command.arguments.first.d
  #   end
  #
  #   messages_with_unique_arguments.map(&:command)
  # end

  def arguments
    # results = {}

    messages_with_unique_argument_sum = @messages.uniq do |m|
      m.command.arguments.reduce(0) { |m, arg_byte| m + arg_byte.d }
    end

    # results[:total] = messages_with_unique_argument_sum.count

    argument_values = messages_with_unique_argument_sum.map do |message|
      message.arguments.map(&:h)
    end

    # indexed[0] = all arguments in position 1 etc
    argument_values_transposed = argument_values.transpose

    # results[:indexed] = { 0 => indexed[0], 1 => indexed[1], 2 => indexed[2] }

    # grouped_unique_values = indexed.group_by {|i| i }
    # grouped_lengths = message_lengths.group_by { |l| l }

    # unique_arg_counts = grouped_unique_values.map { |v, grp| [v, grp.length] }.to_h

    # results.merge!(argument_values)

    argument_values_transposed.map do |pos|
      # uniq_grouped = pos.group_by { |h| h }
      # uniq_grouped.map { |u, grp| [u, grp.count] }
      pos.uniq
    end

    messages_with_unique_argument_sum.map do |u_m|
      u_m.arguments.map(&:h)
    end
  end

  def lengths
    message_lengths = @messages.map do |m|
      m.arguments.length
    end

    grouped_lengths = message_lengths.group_by { |l| l }

    unique_length_counts = grouped_lengths.map { |l, grp| [l, grp.length] }
    unique_length_counts.to_h
  end

  # def group_by(grouped = @messages, property)
  #   LOGGER.warn(criteria)
  #   raise ArgumentError, 'unrecognised property' if SEARCH_PROPERTY.none? { |p| p == property }
  # 
  #   case property
  #   when :command_id
  #     grouped.group_by do |message|
  #       message.command.d
  #     end
  #   end
  # end

  # ************************************************************************* #
  #                                  LAZY SCRIPTS
  # ************************************************************************* #

  # -------------------------------- STATUS -------------------------------- #

  def pingers
    command(1).senders
  end

  def pongers
    command(2).senders
  end

  def silent
    ping_recipients = command(1).recipients
    ping_recipients.select do |recipient|
      recipient_id_decimal = recipient.d
      results = command(2).from(recipient_id_decimal)
      results.nil? || results.empty?
    end
  end

  def alt_pongs
    results = command(2).find_all { |m| m.command.alt? }
    self.class.new(results)
  end

  # def unique(property, index = 0)
  #   case property
  #   when :from
  #   when :to
  #   when :command
  #   when :arguments
  #     # messages.uniq {|m| m.command.arguments.first.d }
  #   end
  # end

  # which commands are exclusively received by a device
  #

  private

  # TODO: implement a collection class to allow chaining calls
  def where(property, *criteria)
    raise ArgumentError, 'unrecognised property' if SEARCH_PROPERTY.none? { |p| p == property }

    case property
    when :command_id
      @messages.find_all do |message|
        c = message.command
        criteria.any? { |crit| crit == c.id[:d] }
      end
    when :to_id
      @messages.find_all do |message|
        # c = message.command
        receiver = message.receiver
        criteria.any? { |crit| crit == receiver.d }
      end
    when :from_id
      @messages.find_all do |message|
        # c = message.command
        sender = message.sender
        criteria.any? { |crit| crit == sender.d }
      end
    else
      raise StandardError, 'whoops!'
    end
  end
end
