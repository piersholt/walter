# frozen_string_literal: true

root = 'application/virtual'

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
