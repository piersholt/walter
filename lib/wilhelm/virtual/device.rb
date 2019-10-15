# frozen_string_literal: true

puts "\tLoading wilhelm/virtual/device"

require_relative 'device/helpers'
require_relative 'device/base'

require_relative 'device/api'
require_relative 'device/capabilities'

require_relative 'device/builder'
require_relative 'device/dynamic/enabled'
require_relative 'device/dynamic/disabled'
require_relative 'device/dynamic'

require_relative 'device/augmented'
require_relative 'device/emulated'

require_relative 'device/constants'

require_relative 'device/bmbt'
require_relative 'device/cdc'
require_relative 'device/cid'
require_relative 'device/diagnostics'
require_relative 'device/dsp'
require_relative 'device/gfx'
require_relative 'device/gt2'
require_relative 'device/ike'
require_relative 'device/lcm'
require_relative 'device/mid'
require_relative 'device/mfl'
require_relative 'device/nav'
require_relative 'device/radio'
require_relative 'device/rcm'
require_relative 'device/ses'
require_relative 'device/tcu'
require_relative 'device/tel'
require_relative 'device/tv'
