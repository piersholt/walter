# frozen_string_literal: true

root = 'application/vehicle'

# require "#{root}/events"

display = "#{root}/display"

require "#{display}/states/defaults"
require "#{display}/states/unknown"
require "#{display}/states/disabled"
require "#{display}/states/enabled"
require "#{display}/states/busy"
require "#{display}/states/available"
require "#{display}/states/captured"
require "#{display}/states/overwritten"

require "#{display}/events/events"
require "#{display}/events/cache_handler"
require "#{display}/events/input_handler"
require "#{display}/events/listener"

require "#{display}/cache/attributes"
require "#{display}/cache/layout_cache"
require "#{display}/cache/cache"

require "#{display}/display"
