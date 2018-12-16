# frozen_string_literal: true

root = 'data_link'

require "#{root}/frame/frame"
require "#{root}/frame/frame_synchronisation"
require "#{root}/receiver"

map_root = "#{root}/maps"
require "#{map_root}/address_lookup_table"

llc_root = "#{root}/LLC"
require "#{llc_root}/multiplexer.rb"
require "#{llc_root}/demultiplexer.rb"

handlers_root = "#{root}/handlers"
require "#{handlers_root}/data_link_handler"
require "#{handlers_root}/data_link_listener"
