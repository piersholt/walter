# frozen_string_literal: true

puts "\tLoading wilhelm/core/ibus/data/commands"

require_relative 'commands/chars'

require_relative 'commands/base_command'
require_relative 'commands/obc_display'
require_relative 'commands/ccm_display'
require_relative 'commands/media_display'
require_relative 'commands/pong'
require_relative 'commands/temperature'
require_relative 'commands/speed'
require_relative 'commands/ignition'
require_relative 'commands/key'
require_relative 'commands/button'
require_relative 'commands/led'
require_relative 'commands/ike_sensors'
require_relative 'commands/lamp'
require_relative 'commands/radio_led'

puts "\tLoading wilhelm/core/ibus/data/commands/builder"

require_relative 'commands/builder/parameter_configuration'
require_relative 'commands/builder/command_configuration'
require_relative 'commands/builder/base_command_builder'

puts "\tLoading wilhelm/core/ibus/data/commands/paramaterized/parameter"

require_relative 'commands/paramaterized/parameter/delegated_command_parameter'
require_relative 'commands/paramaterized/parameter/base_parameter'
require_relative 'commands/paramaterized/parameter/bit_array_parameter'
require_relative 'commands/paramaterized/parameter/switched_parameter'
require_relative 'commands/paramaterized/parameter/mapped_parameter'
require_relative 'commands/paramaterized/parameter/chars_parameter'

puts "\tLoading wilhelm/core/ibus/data/commands/paramaterized"

require_relative 'commands/paramaterized/parameterized_command'
require_relative 'commands/paramaterized/cd_changer_request'
require_relative 'commands/paramaterized/button'
require_relative 'commands/paramaterized/mfl_button'
require_relative 'commands/paramaterized/mfl_volume'

puts "\tLoading wilhelm/core/ibus/data/commands/paramaterized/builder"

require_relative 'commands/paramaterized/builder/bit_array_parameter_configuration'
require_relative 'commands/paramaterized/builder/paramaterized_command_builder'
