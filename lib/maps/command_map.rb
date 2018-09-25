require 'maps/map'
require 'command/base_command'
require 'command/obc_display'
require 'command/ccm_display'
require 'command/media_display'
require 'command/chars'
require 'command/pong'
require 'command/temperature'
require 'command/speed'
require 'command/ignition'
require 'command/key'
require 'command/button'
require 'command/led'
require 'command/ike_sensors'
require 'command/lamp'
require 'command/radio_led'
require 'command_configuration'

require 'singleton'

class CommandMap < Map
  include Singleton
  PROC = 'CommandMap'.freeze

  COMMANDS_MAP_NAME = 'commands'.freeze
  DEFAULT_COMMAND_NAMESPACE = 'Commands'.freeze

  def initialize(map = COMMANDS_MAP_NAME)
    super(map)
  end

  def self.reload!
    instance.reload!
  end

  def find_or_default(command_id)
    LOGGER.debug(PROC) { "#find_or_default(#{command_id})" }
    mapped_result = nil

    begin
      mapped_result = find(command_id)
    rescue IndexError
      LOGGER.error(PROC) {
        "Command ID: #{command_id}, #{DataTools.d2h(command_id)} not found!" }
      mapped_result = super(:default)
      mapped_result[:id][:d] = command_id
    end

    mapped_result[:default_id] = command_id

    command_configuration = CommandConfiguration.new(mapped_result)
    command_configuration
  end

  def config(command_id)
    find_or_default(command_id)
  end

  # def klass(command_id, arguments = nil)
  #   command_config = find_or_default(command_id)
  #   instantiate_klass(command_config, arguments)
  # end
  #
  # def instantiate_klass(command_config, arguments)
  #   command_klass = command_config.klass_constant
  #   klass_builder = command_config.klass_builder
  #
  #   id = command_config.id
  #
  #   properties = command_config.properties_hash
  #   properties[:arguments] = arguments unless arguments.nil?
  #
  #   command_klass.new(id, properties)
  # end
end
