# frozen_string_literal: true

root = 'application'

map_root = "#{root}/maps"
# require "#{map_root}/address_lookup_table"
require "#{map_root}/device_map"
require "#{map_root}/command_map"

io_root = "#{root}/io"
require "#{io_root}/io"

virtual_root = "#{root}/virtual"
require "#{virtual_root}/virtual"
