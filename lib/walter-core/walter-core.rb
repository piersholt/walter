# frozen_string_literal: true

puts 'Loading walter-core'

puts "\tLoading walter-core/serialport"
require 'serialport'

require 'helpers'
require 'shared/shared'
require 'physical/physical'
require 'data_link/datalink'
require 'ibus/ibus'

puts "\tDone!"
