# frozen_string_literal: true

# @deprecated ?
require_relative 'command/chars'

puts "\tLoading wilhelm/virtual/protocol/commands"
require_relative 'command/base'
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
# require_relative 'command/paramaterized/model/indexed'
# require_relative 'command/paramaterized/model/bit_array'
# require_relative 'command/paramaterized/model/indexed_arguments'

puts "\tLoading wilhelm/virtual/protocol/command/paramaterized"
require_relative 'command/paramaterized'

puts "\tLoading wilhelm/virtual/protocol/command/paramaterized/parameter"
require_relative 'command/paramaterized/parameter'
