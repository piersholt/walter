# frozen_string_literal: true

root = 'application/virtual'

api = "#{root}/api"
require "#{api}/api"

device = "#{root}/device"
require "#{device}/device"

bus = "#{root}/bus"
require "#{bus}/bus_handler"
require "#{bus}/bus"
require "#{bus}/initialization"
require "#{bus}/message"
# require "#{bus}/packet_handler"
require "#{bus}/packet_wrapper"
