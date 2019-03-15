# frozen_string_literal: true

puts 'Loading walter-core'

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
