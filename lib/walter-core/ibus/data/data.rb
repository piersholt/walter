# frozen_string_literal: true

puts "\tLoading walter-core/ibus/data"

data_root = 'ibus/data'

commands_root = "#{data_root}/commands"
# parameter_root = "#{commands_root}/parameter"
builder_root = "#{commands_root}/builder"

paramaterized_root = "#{commands_root}/paramaterized"
paramaterized_parameter_root = "#{paramaterized_root}/parameter"
paramaterized_builder_root = "#{paramaterized_root}/builder"

devices_root = "#{data_root}/devices"
message_root = "#{data_root}/message"

puts "\tLoading walter-core/ibus/data/commands"

require "#{commands_root}/chars"

require "#{commands_root}/base_command"
require "#{commands_root}/obc_display"
require "#{commands_root}/ccm_display"
require "#{commands_root}/media_display"
require "#{commands_root}/pong"
require "#{commands_root}/temperature"
require "#{commands_root}/speed"
require "#{commands_root}/ignition"
require "#{commands_root}/key"
require "#{commands_root}/button"
require "#{commands_root}/led"
require "#{commands_root}/ike_sensors"
require "#{commands_root}/lamp"
require "#{commands_root}/radio_led"

require "#{builder_root}/parameter_configuration"
require "#{builder_root}/command_configuration"
require "#{builder_root}/base_command_builder"

require "#{paramaterized_parameter_root}/delegated_command_parameter"
require "#{paramaterized_parameter_root}/base_parameter"
require "#{paramaterized_parameter_root}/bit_array_parameter"
require "#{paramaterized_parameter_root}/switched_parameter"
require "#{paramaterized_parameter_root}/mapped_parameter"
require "#{paramaterized_parameter_root}/chars_parameter"
require "#{paramaterized_root}/parameterized_command"

require "#{paramaterized_root}/cd_changer_request"
require "#{paramaterized_root}/button"
require "#{paramaterized_root}/mfl_button"
require "#{paramaterized_root}/mfl_volume"

require "#{paramaterized_builder_root}/bit_array_parameter_configuration"
require "#{paramaterized_builder_root}/paramaterized_command_builder"

require "#{devices_root}/base_device"

# Messages
require "#{message_root}/message"
require "#{message_root}/messages"
