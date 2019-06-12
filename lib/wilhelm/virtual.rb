# frozen_string_literal: true

puts 'Loading wilhelm/virtual'

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
LogActually.is_all_around(:tel)
LogActually.tel.i

require_relative 'virtual/constants'
require_relative 'virtual/device'
require_relative 'virtual/bus'

puts "\tDone!"
