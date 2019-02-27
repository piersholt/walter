# frozen_string_literal: true

puts 'Loading walter-api'

puts "\tLoading walter-api/display"

display_root = 'display'
require "#{display_root}/states/defaults"
require "#{display_root}/states/unknown"
require "#{display_root}/states/disabled"
require "#{display_root}/states/enabled"
require "#{display_root}/states/busy"
require "#{display_root}/states/available"
require "#{display_root}/states/captured"
require "#{display_root}/states/overwritten"

require "#{display_root}/events/cache_handler"
require "#{display_root}/events/input_handler"
require "#{display_root}/events/listener"

require "#{display_root}/cache/value"
require "#{display_root}/cache/attributes"
require "#{display_root}/cache/layout_cache"
require "#{display_root}/cache/cache"

require "#{display_root}/display"

puts "\tDone!"
