# frozen_string_literal: true

puts 'Loading walter-core'

# external dependencies
require 'serialport'

# local dependencies
require 'physical/byte'
require 'physical/byte_basic'
require 'physical/bytes'
# require 'application/message'

require 'helpers'
require 'shared/shared'
require 'data_link/datalink'

require 'physical/interface'
require 'data_link/transmitter'

require 'ibus/ibus'

puts "\tDone!"
