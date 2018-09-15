require 'singleton'

class DisplayHandler
  include Singleton
  include Event

  NOISEY = [0x01, 0x02, 0x18, 0x19, 0x5B, 0x10, 0x11,0x21, 0x79, 0x7A].freeze

  def self.i
    instance
  end

  def initialize
    enable
  end

  def inspect
    str_buffer = "<DisplayHandler>"
    str_buffer.concat("\nFilters:")
    str_buffer.concat("\n\tCommands: #{filtered_commands}")
    str_buffer.concat("\n\tTo: #{filtered_recipients}")
    str_buffer.concat("\n\tFrom: #{filtered_senders}")
  end

  def add_message(message)
    filtered_output(message)
  end

  def update(action, properties)
    case action
    when EXIT
      LOGGER.info("DisplayHandler") { "Exit: Disabling output." }
      # hide the message output as it clutters the exit log messages
      disable
    when MESSAGE_RECEIVED
      begin
        filtered_output(properties[:message])
      rescue StandardError => e
        LOGGER.error("#{self.class} Exception: #{e}")
        # break here
        e.backtrace.each { |l| LOGGER.error(l) }
        puts 'waiting for a mate.'
      end
    end
  end

  # ************************************************************************* #
  #                              OUTPUT CONTROL
  # ************************************************************************* #

  def disable
    LOGGER.info("DisplayHandler") { "Outout disabled." }
    @output_enabled = false
  end

  def enable
    LOGGER.debug("DisplayHandler") { "Output enabled." }
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
    @filtered_senders = populate
    true
  end

  def f_t(*to_ids)
    filtered_recipients.clear if filtered_recipients.size >= 5
    return false if filtered_recipients.any?  { |t_id| @filtered_recipients.include?(t_id) }
    to_ids.each { |t_id| @filtered_recipients << t_id }
    true
  end

  def f_f(*from_ids)
    filtered_senders.clear if filtered_senders.size >= 5
    return false if filtered_senders.any? { |f_id| @filtered_senders.include?(f_id) }
    from_ids.each { |f_id| @filtered_senders << f_id  }
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

  def h_c(*command_ids)
    hide_commands(*command_ids)
  end

  def hide_commands(*command_ids)
    command_ids.each { |command_id| filtered_commands.delete(command_id) }
    true
  end

  # ------------------------------ FILTER: MACRO ------------------------------ #

  def shutup!
    LOGGER.info("Shutting up commands: #{NOISEY.join(', ')}.")
    hide_commands(*NOISEY)
    true
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

    matches_a_sender = filtered_senders.one? do |c|
      c == message.from.d
    end

    return false unless output_enabled?

    if matches_a_command && matches_a_recipient && matches_a_sender
      LOGGER.info("DisplayHandler") { message }
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

  def filtered_senders
    @filtered_senders ||= populate
  end

  def populate
    Array.new(256) { |i| i }
  end
end
