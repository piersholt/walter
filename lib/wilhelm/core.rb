# frozen_string_literal: true

puts 'Loading wilhelm/core'

# Walter-Core
# LogActually.is_all_around(:interface)
# LogActually.is_all_around(:datalink)
# LogActually.is_all_around(:multiplexer)
# LogActually.is_all_around(:demultiplexer)
# LogActually.is_all_around(:transmitter)
# LogActually.is_all_around(:parameterized)
LogActually.is_all_around(:core)

# LogActually.interface.i
# LogActually.datalink.i
# LogActually.multiplexer.i
# LogActually.demultiplexer.i
# LogActually.transmitter.i
# LogActually.parameterized.i
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
require_relative 'core/physical'
require_relative 'core/datalink'
require_relative 'core/listener'
require_relative 'core/handler'
require_relative 'core/ibus'
require_relative 'core/context'

puts "\tDone!"
