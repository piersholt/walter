require 'singleton'

class DisplayHandler < BaseHandler
  include CommandTools
  include Singleton

  PROC = 'DisplayHandler'.freeze

  NOISEY = [*KEEP_ALIVE, *SPEED, *TEMPERATURE, *IGNITION, *COUNTRY, *BUTTON, *VEHICLE, *LAMP].freeze

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
      LOGGER.info(PROC) { "Exit: Disabling output." }
      # hide the message output as it clutters the exit log messages
      disable
    when MESSAGE_RECEIVED
      begin
        message = properties[:message]
        filtered_output(message)
      rescue StandardError => e
        LOGGER.error(PROC) { "#{e}" }
        LOGGER.error(PROC) { "#{message}" }
        e.backtrace.each { |l| LOGGER.error(PROC) { l } }
      end
    end
  end

  # ************************************************************************* #
  #                              OUTPUT CONTROL
  # ************************************************************************* #

  def disable
    LOGGER.info(PROC) { "Outout disabled." }
    @output_enabled = false
  end

  def enable
    LOGGER.debug(PROC) { "Output enabled." }
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
    @filtered_recipients = populate_devices
    @filtered_senders = populate_devices
    true
  end

  # ------------------------------ RECIPIENT ------------------------------ #

  def f_t(*to_idents)
    filtered_recipients.clear if filtered_recipients.size >= 5
    return false if filtered_recipients.any?  { |to_ident| @filtered_recipients.include?(to_ident) }
    to_idents.each { |to_ident| @filtered_recipients << to_ident }
    true
  end

  # ------------------------------ SENDER ------------------------------ #

  def f_f(*from_idents)
    filtered_senders.clear if filtered_senders.size >= 5
    return false if filtered_senders.any? { |from_ident| @filtered_senders.include?(from_ident) }
    from_idents.each { |from_ident| @filtered_senders << from_ident  }
    true
  end

  # ------------------------------ COMMANDS ------------------------------ #

  def f_c(*command_ids)
    filter_commands(*command_ids)
  end

  def filter_commands(*command_ids)
    LOGGER.info(PROC) { "Filtering commands: #{command_ids}" }
    filtered_commands.clear if filtered_commands.size >= 5
    return false if command_ids.any? { |c_id| @filtered_commands.include?(c_id) }
    command_ids.each { |command_id| @filtered_commands << command_id }
    true
  end

  def h_c(*command_ids)
    hide_commands(*command_ids)
  end

  def hide_commands(*command_ids)
    LOGGER.info(PROC) { "Hiding commands: #{command_ids}" }
    command_ids.each { |command_id| filtered_commands.delete(command_id) }
    true
  end

  # ------------------------------ FILTER: MACRO ------------------------------ #

  def shutup!
    LOGGER.info(PROC) { ("Shutting up commands: #{NOISEY.join(', ')}.") }
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
      c == message.to
    end

    matches_a_sender = filtered_senders.one? do |c|
      c == message.from
    end

    return false unless output_enabled?

    if matches_a_command && matches_a_recipient && matches_a_sender
      LOGGER.info(PROC) { message }
      return true
    else
      return false
    end
  end

  # ------------------------------ HELPERS ------------------------------ #

  def filtered_commands
    @filtered_commands ||= populate
  end

  def filtered_recipients
    @filtered_recipients ||= populate_devices
  end

  def filtered_senders
    @filtered_senders ||= populate_devices
  end

  def populate
    Array.new(256) { |i| i }
  end

  def populate_devices
    AddressLookupTable.instance.idents
  end
end
