# frozen_string_literal: true

puts 'Loading walter-virtual'

# Walter-Virtual
LogActually.is_all_around(:virtual)
LogActually.virtual.i
LogActually.is_all_around(:api)
LogActually.api.i

LogActually.is_all_around(:cdc)
LogActually.cdc.i
LogActually.is_all_around(:rad)
LogActually.rad.i
LogActually.is_all_around(:gfx)
LogActually.gfx.i
LogActually.is_all_around(:bmbt)
LogActually.bmbt.i
LogActually.is_all_around(:mfl)
LogActually.mfl.i

require 'device/device'

bus_root = 'bus'
require "#{bus_root}/devices"
require "#{bus_root}/bus_handler"
require "#{bus_root}/bus"
require "#{bus_root}/initialization"
require "#{bus_root}/message"
require "#{bus_root}/packet_wrapper"

puts "\tDone!"
