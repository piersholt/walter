# frozen_string_literal: true

puts 'Loading wilhelm/core'

LogActually.is_all_around(:core)

LogActually.core.i

module Wilhelm
  # Setup namespace due to short class names in wilhelm-core
  module Core
    LOGGER = LogActually.core
  end
end

puts "\tLoading wilhelm/core/serialport"
require 'serialport'

require_relative 'core/constants'
require_relative 'core/helpers'
require_relative 'core/errors'

require_relative 'core/physical'
require_relative 'core/datalink'
require_relative 'core/listener'
require_relative 'core/handler'
require_relative 'core/context'

puts "\tDone!"
