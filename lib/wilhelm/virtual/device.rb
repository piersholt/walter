# frozen_string_literal: true

puts "\tLoading wilhelm/virtual/device"

require_relative 'device/events'
require_relative 'device/receivable'
require_relative 'device/base'
# TODO: remove broadcast
require_relative 'device/broadcast'

require_relative 'device/dynamic'
require_relative 'device/augmented'
require_relative 'device/emulated'
