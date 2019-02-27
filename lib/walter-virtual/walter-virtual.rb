# frozen_string_literal: true

device_root = '/device'

require "#{device_root}/api/api"
require "#{device_root}/capabilities/"
require "#{device_root}/dynamic"
require "#{device_root}/receivable"
require "#{device_root}/base"

# require "#{root}/broadcast"

require "#{root}/capabilities/capabilities"

require "#{root}/dynamic/dynamic"

bus_root = "#{root}/bus"

require "#{bus_root}/devices"
require "#{bus_root}/bus_handler"
require "#{bus_root}/bus"
require "#{bus_root}/initialization"
require "#{bus_root}/message"
# require "#{bus_root}/packet_handler"
require "#{bus_root}/packet_wrapper"
