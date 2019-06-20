# frozen_string_literal: true

puts 'Loading wilhelm/virtual'

LogActually.is_all_around(:virtual)

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
