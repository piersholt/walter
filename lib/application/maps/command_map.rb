# require 'maps/map'
# require 'application/commands/base_command'
# require 'application/commands/parameterized_command'
# require 'application/commands/obc_display'
# require 'application/commands/ccm_display'
# require 'application/commands/media_display'
# require 'application/commands/chars'
# require 'application/commands/pong'
# require 'application/commands/temperature'
# require 'application/commands/speed'
# require 'application/commands/ignition'
# require 'application/commands/key'
# require 'application/commands/button'
# require 'application/commands/led'
# require 'application/commands/ike_sensors'
# require 'application/commands/lamp'
# require 'application/commands/radio_led'
# require 'application/commands/builder/command_configuration'

require 'singleton'

class CommandMap < BaseMap
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
