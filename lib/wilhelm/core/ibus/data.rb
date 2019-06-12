# frozen_string_literal: true

puts "\tLoading wilhelm/core/ibus/data"

# puts "\tLoading wilhelm/core/ibus/data/commands"

require_relative 'data/commands'

puts "\tLoading wilhelm/core/ibus/data/devices"

require_relative 'data/devices/base_device'

puts "\tLoading wilhelm/core/ibus/data/message"

require_relative 'data/message/message'
require_relative 'data/message/messages'
