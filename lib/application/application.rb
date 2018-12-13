# frozen_string_literal: true

root = 'application'

map_root = "#{root}/maps"
# require "#{map_root}/address_lookup_table"
require "#{map_root}/device_map"
require "#{map_root}/command_map"

virtual_root = "#{root}/virtual"
require "#{virtual_root}/virtual"
