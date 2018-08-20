require 'register'

class Command
  extend Register
  include Register

  attr_accessor :id, :address, :short_name, :long_name, :created_at, :updated_at, :type
  # alias :id :address

  def initialize(command_id, short_name = DataTools.decimal_to_hex(command_id, true), long_name = 'Unknown')
    setup_register(:command)
    @id = command_id
    @address = { h: DataTools.decimal_to_hex(command_id), d: command_id }

    @short_name = short_name
    @long_name = long_name

    @created_at = DateTime.now
    @updated_at = DateTime.now

    # @arguments = arguments
  end

  def has_type?
    @type.nil? ? false : true
  end

  def self.lookup_command(key)
    LOGGER.debug("Command Lookup / #{key}")
    result = lookup(:command, key)
    LOGGER.debug("Command Lookup / #{key} / Result: #{result}")
    result.updated_at = DateTime.now unless result.nil?
    result
  end

  def self.close
    close_register(:command)
  end

  def self.all
    register[:command]
  end

  def add_receiver(device_id)
    LOGGER.debug("#{self.class}#add_reciver(#{device_id})")
    receivers << device_id unless receivers.include?(device_id)
    LOGGER.debug("#{self.class}#add_reciver / #{receivers}")
    true
  end

  def receivers
    @receivers ||= []
  end

  # def self.update(message)
  #   close if message.nil? && return
  #   command = message.command
  #   create(:command, command.id, message.command)
  # end

  def self.update(command_id, command)
    close if command_id.nil? && return
    # command = message.command
    create(:command, command_id, command)
  end

  def to_s
    "#{@address}: #{@short_name} / #{@long_name}"
  end
end
