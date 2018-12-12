# frozen_string_literal: true

root = 'datalink'

map_root = "#{root}/maps"
require "#{map_root}/address_lookup_table"
require "#{map_root}/device_map"
require "#{map_root}/command_map"

llc_root = "#{root}/LLC"
require "#{llc_root}/multiplexer.rb"
require "#{llc_root}/demultiplexer.rb"

handlers_root = "#{root}/handlers"
require "#{handlers_root}/data_link_handler"
require "#{handlers_root}/data_link_listener"
require "#{handlers_root}/frame_handler"
require "#{handlers_root}/frame_listener"

require "#{handlers_root}/frame_listener"
