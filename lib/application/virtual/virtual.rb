# frozen_string_literal: true

root = 'application/virtual'

require "#{root}/events"

display = "#{root}/display"
require "#{display}/states/busy"
require "#{display}/states/idle"
require "#{display}/states/in_use"
require "#{display}/states/overwritten"
require "#{display}/listener"
require "#{display}/display"

device = "#{root}/device"
require "#{device}/device"

bus = "#{root}/bus"
require "#{bus}/devices"
require "#{bus}/bus_handler"
require "#{bus}/bus"
require "#{bus}/initialization"
require "#{bus}/message"
# require "#{bus}/packet_handler"
require "#{bus}/packet_wrapper"
