# frozen_string_literal: true

puts "\tLoading walter/core/ibus"

root = 'ibus'

data_root = "#{root}/data"
require "#{data_root}/data"

map_root = "#{root}/maps"
require "#{map_root}/device_map"
require "#{map_root}/command_map"

# vehicle_root = "#{root}/vehicle"
# require "#{vehicle_root}/vehicle"
#
# virtual_root = "#{root}/virtual"
# require "#{virtual_root}/virtual"
