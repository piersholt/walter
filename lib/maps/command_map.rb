require 'maps/map'
require 'command/base_command'
require 'command/parameterized_command'
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
require 'command/builder/command_configuration'

require 'singleton'

class CommandMap < Map
  include Singleton
  PROC = 'CommandMap'.freeze

  COMMANDS_MAP_NAME = 'commands'.freeze
  DEFAULT_COMMAND_NAMESPACE = 'Command'.freeze

  def initialize(map = COMMANDS_MAP_NAME)
    super(map)
  end

  def self.reload!
    instance.reload!
  end

  def find_or_default(command_id, from = nil)
    LOGGER.debug(PROC) { "#find_or_default(#{command_id})" }
    mapped_result = nil

    begin
      mapped_result = find(command_id)
    rescue IndexError
      LOGGER.error(PROC) {
        "Command ID: #{command_id}, #{DataTools.d2h(command_id, true)} not found!" }
      mapped_result = find(:default)
      mapped_result[:id][:d] = command_id
    end

    if from
      schemas = mapped_result[:schemas]
      has_schema = schemas.include?(from) if schemas
      mapped_result.replace(mapped_result[from]) if has_schema
    end

    mapped_result[:default_id] = command_id

    command_configuration = CommandConfiguration.new(mapped_result)
    command_configuration
  end

  def config(command_id, from = nil)
    find_or_default(command_id, from)
  end
end
