# frozen_string_literal: true

root = 'application'

pdu_root = "#{root}/pdu"
require "#{pdu_root}/pdu"

map_root = "#{root}/maps"
require "#{map_root}/device_map"
require "#{map_root}/command_map"

# io_root = "#{root}/io"
# require "#{io_root}/io"

vehicle_root = "#{root}/vehicle"
require "#{vehicle_root}/vehicle"

virtual_root = "#{root}/virtual"
require "#{virtual_root}/virtual"
