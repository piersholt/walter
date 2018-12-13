# frozen_string_literal: true

pdu_root = 'application/pdu'

commands_root = "#{pdu_root}/commands"
parameter_root = "#{commands_root}/parameter"
builder_root = "#{commands_root}/builder"
devices_root = "#{pdu_root}/devices"
message_root = "#{pdu_root}/message"

require "#{parameter_root}/delegated_command_parameter"

require "#{parameter_root}/base_parameter"
require "#{parameter_root}/bit_array_parameter"
require "#{parameter_root}/switched_parameter"
require "#{parameter_root}/mapped_parameter"
require "#{parameter_root}/chars_parameter"

require "#{commands_root}/chars"

require "#{commands_root}/base_command"
require "#{commands_root}/parameterized_command"
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
require "#{builder_root}/bit_array_parameter_configuration"

require "#{commands_root}/builder/command_configuration"

require "#{builder_root}/base_command_builder"
require "#{builder_root}/paramaterized_command_builder"

require "#{devices_root}/base_device"

# Messages
require "#{message_root}/message"
require "#{message_root}/messages"
