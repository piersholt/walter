# frozen_string_literal: true

puts 'Loading walter-virtual'

puts "\tLoading walter-virtual/device"

device_root = 'device'
require "#{device_root}/events"
require "#{device_root}/receivable"
require "#{device_root}/base"

puts "\tLoading walter-virtual/device/dynamic"

require "#{device_root}/api/api"
require "#{device_root}/capabilities/capabilities"
require "#{device_root}/device_builder"
require "#{device_root}/dynamic"

require "#{device_root}/augmented/augmented"
require "#{device_root}/emulated/emulated"

puts "\tLoading walter-virtual/bus"

bus_root = 'bus'
require "#{bus_root}/devices"
require "#{bus_root}/bus_handler"
require "#{bus_root}/bus"
require "#{bus_root}/initialization"
require "#{bus_root}/message"
require "#{bus_root}/packet_wrapper"

puts "\tDone!"
