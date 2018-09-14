require 'maps/map'
require 'commands/base_command'
require 'commands/obc_display'
require 'commands/ccm_display'
require 'commands/media_display'
require 'commands/chars'
require 'commands/pong'
require 'commands/temperature'
require 'commands/speed'
require 'commands/ignition'
require 'commands/key'
require 'commands/button'
require 'commands/led'

require 'singleton'

class CommandMap < Map
  COMMANDS_MAP_NAME = 'commands'.freeze
  DEFAULT_COMMAND_NAMESPACE = 'Commands'.freeze
  # DEFAULT_KLASS = 'BaseCommand'

  include Singleton

  def initialize
    super(COMMANDS_MAP_NAME)
  end

  def self.reload!
    instance.reload!
  end

  def klass(command_id, args = nil)
    LOGGER.debug("#{self.class}") { "#find(#{command_id})" }
    begin
      mapped_result = find(command_id)
    rescue IndexError
      LOGGER.error('CommandMap') {"Command ID: #{command_id}, #{DataTools.decimal_to_hex(command_id)} not found!" }
      mapped_result = super(:default)
      mapped_result[:id][:d] = command_id
    end
    mapped_result[:id] = Byte.new(:decimal, command_id)
    # When a new message handler calls #find it will pass the message
    # parameters as an argument
    mapped_result[:properties][:arguments] = args unless args.nil?
    # mapped_result[:arguments] = args unless args.nil?

    instantiate_klass(mapped_result)
  end

  private

  def command_klass(command_klass_name)
    command_namespace = DEFAULT_COMMAND_NAMESPACE
    command_klass_name = klass_const_string(command_namespace, command_klass_name)

    # Kernel.const_defined?(klass_const)
    Kernel.const_get(command_klass_name)
  end

  def instantiate_klass(mapped_object)
    command_klass = command_klass(mapped_object[:klass])

    id = mapped_object[:id]
    properties = mapped_object[:properties]

    command_klass.new(id, properties)
  end

  def klass_const_string(command_namespace, klass)
    "#{command_namespace}::#{klass}"
  end

  # @deprecated
  public

  # onot part of map as it's specific to the contents of the map
  # def find_by(args)
  #   # binding.pry
  #   LOGGER.debug("#{self.class}#find_by(#{args})")
  #   # puts args
  #   id = args[:id]
  #   # super.public_send(:find, id)
  # end

  # lookup the command by decimal ID
  # instantiate a command of type mapped_object.klass
  # def find()
  #   result.add_observers(self, :update_map)
  # end

  # whenHash a command that's instanced from the map
  # has udpate called it notifies the parent map.
  # i want the map to be very dynamic
  # over time i can update the mapped objet klass
  # types and the new types are hidden from the update
  # implementation
  # def update_map(args)
  #
  # end
end

# class Command
#   def update
#     change(true)
#     notify_observers(self)
#   end
# end
