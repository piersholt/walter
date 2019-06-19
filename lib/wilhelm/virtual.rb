# frozen_string_literal: true

puts 'Loading wilhelm/virtual'

# LogActually.is_all_around(:cdc)
# LogActually.is_all_around(:rad)
# LogActually.is_all_around(:gfx)
# LogActually.is_all_around(:bmbt)
# LogActually.is_all_around(:mfl)
# LogActually.is_all_around(:tel)
LogActually.is_all_around(:virtual)

# LogActually.cdc.i
# LogActually.rad.i
# LogActually.gfx.i
# LogActually.bmbt.i
# LogActually.mfl.i
# LogActually.tel.i
LogActually.virtual.i

module Wilhelm
  module Virtual
    LOGGER = LogActually.virtual
  end
end

require_relative 'virtual/constants'
require_relative 'virtual/helpers'
require_relative 'virtual/device'
require_relative 'virtual/bus'
require_relative 'virtual/listener'
require_relative 'virtual/handler'

puts "\tDone!"
