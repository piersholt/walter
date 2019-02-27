# frozen_string_literal: true

puts "\tLoading walter-virtual/device/dynamic"

root = 'device/dynamic'

require "#{root}/device_builder"
require "#{root}/device"

# require "#{root}/diagnostics/device"

require "#{root}/augmented/augmented"
require "#{root}/emulated/emulated"
