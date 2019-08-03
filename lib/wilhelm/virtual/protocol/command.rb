# frozen_string_literal: true

puts "\tLoading wilhelm/virtual/protocol/commands"

require_relative 'command/chars'

require_relative 'command/base_command'
require_relative 'command/obc_display'
require_relative 'command/ccm_display'
require_relative 'command/media_display'
require_relative 'command/pong'
require_relative 'command/temperature'
require_relative 'command/speed'
require_relative 'command/ignition'
require_relative 'command/key'
require_relative 'command/button'
require_relative 'command/led'
require_relative 'command/ike_sensors'
require_relative 'command/lamp'
require_relative 'command/radio_led'

puts "\tLoading wilhelm/virtual/protocol/command/configuration"
require_relative 'command/configuration'

puts "\tLoading wilhelm/virtual/protocol/command/builder"
require_relative 'command/builder'

puts "\tLoading wilhelm/virtual/protocol/command/paramaterized/model"

require_relative 'command/paramaterized/model/indexed'
require_relative 'command/paramaterized/model/bit_array'
require_relative 'command/paramaterized/model/indexed_arguments'

puts "\tLoading wilhelm/virtual/protocol/command/paramaterized/parameter"

require_relative 'command/paramaterized/parameter/base_parameter'
require_relative 'command/paramaterized/parameter/bit_array_parameter'
require_relative 'command/paramaterized/parameter/switched_parameter'
require_relative 'command/paramaterized/parameter/mapped_parameter'
require_relative 'command/paramaterized/parameter/chars_parameter'
require_relative 'command/paramaterized/parameter/data_parameter'

puts "\tLoading wilhelm/virtual/protocol/command/paramaterized"

require_relative 'command/paramaterized/parameterized_command'
require_relative 'command/paramaterized/cd_changer_request'
require_relative 'command/paramaterized/button'
require_relative 'command/paramaterized/mfl_button'
require_relative 'command/paramaterized/mfl_volume'
