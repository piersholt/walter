# frozen_string_literal: true

puts 'Loading wilhelm/core'

# Walter-Core
LogActually.is_all_around(:interface)
LogActually.interface.i
LogActually.is_all_around(:datalink)
LogActually.datalink.i
LogActually.is_all_around(:multiplexer)
LogActually.multiplexer.i
LogActually.is_all_around(:demultiplexer)
LogActually.demultiplexer.i
LogActually.is_all_around(:transmitter)
LogActually.transmitter.i
LogActually.is_all_around(:parameterized)
LogActually.parameterized.i

puts "\tLoading wilhelm/core/serialport"
require 'serialport'

require_relative 'core/constants/constants'
require_relative 'core/helpers/helpers'
require_relative 'core/mixins/mixins'
require 'shared/shared'
require 'physical/physical'
require 'data_link/datalink'
require 'ibus/ibus'

puts "\tDone!"
