# frozen_string_literal: true

puts 'Loading walter-core'

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

puts "\tLoading walter-core/serialport"
require 'serialport'

require_relative 'constants/constants'
require_relative 'helpers/helpers'
require_relative 'mixins/mixins'
require 'shared/shared'
require 'physical/physical'
require 'data_link/datalink'
require 'ibus/ibus'

puts "\tDone!"
