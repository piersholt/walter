# frozen_string_literal: true

puts 'Loading walter-virtual'

require 'device/device'

bus_root = 'bus'
require "#{bus_root}/devices"
require "#{bus_root}/bus_handler"
require "#{bus_root}/bus"
require "#{bus_root}/initialization"
require "#{bus_root}/message"
require "#{bus_root}/packet_wrapper"

puts "\tDone!"
