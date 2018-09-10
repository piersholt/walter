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

  def find(command_id, args = nil)
    LOGGER.debug("#{self.class}") { "#find(#{command_id})" }
    begin
      mapped_result = super(command_id)
    rescue IndexError
      LOGGER.error("Command ID:#{command_id} not found!")
      mapped_result = super(:default)
    end
    # When a new message handler calls #find it will pass the message
    # parameters as an argument
    mapped_result[:properties][:arguments] = args unless args.nil?
    # mapped_result[:arguments] = args unless args.nil?

    instantiate_klass(mapped_result)
  end

  private

  def instantiate_klass(mapped_object)
    klass_ns = DEFAULT_COMMAND_NAMESPACE
    object_klass = mapped_object[:klass]
    klass = klass_const(klass_ns, object_klass)

    id = mapped_object[:id]
    properties = mapped_object[:properties]
    Kernel.const_defined?(klass)
    klass = Kernel.const_get(klass)
    klass.new(id, properties)
  end

  def klass_const(klass_ns, klass)
    "#{klass_ns}::#{klass}"
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
