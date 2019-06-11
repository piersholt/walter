# frozen_string_literal: true

puts "\tLoading wilhelm/core/data_link"

root = 'data_link'

# puts "\tLoading wilhelm/core/p-bus"
# p_bus_root = "#{root}/p-bus"
# require "#{p_bus_root}/frames"
# require "#{p_bus_root}/frame_adapter"
# require "#{p_bus_root}/frame_synchronisation"

puts "\tLoading wilhelm/core/data_link/frame"
require "#{root}/frame/frame"
require "#{root}/frame/frame_synchronisation"

puts "\tLoading wilhelm/core/data_link/fbzv"
require "#{root}/fbzv/frame_synchronisation"

puts "\tLoading wilhelm/core/data_link/transceiver"
require "#{root}/receiver"
require "#{root}/transmitter"

puts "\tLoading wilhelm/core/data_link/maps"
map_root = "#{root}/maps"
require "#{map_root}/address_lookup_table"

puts "\tLoading wilhelm/core/data_link/llc"
llc_root = "#{root}/llc"
require "#{llc_root}/multiplexer.rb"
require "#{llc_root}/demultiplexer.rb"

puts "\tLoading wilhelm/core/data_link/handlers"
handlers_root = "#{root}/handlers"
require "#{handlers_root}/data_link_handler"
require "#{handlers_root}/data_link_listener"
