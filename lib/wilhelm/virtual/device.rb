# frozen_string_literal: true

puts "\tLoading wilhelm/virtual/device"

require_relative 'device/helpers'
require_relative 'device/base'

require_relative 'device/api'
require_relative 'device/capabilities'
require_relative 'device/builder'
require_relative 'device/dynamic'

require_relative 'device/augmented'
require_relative 'device/emulated'

require_relative 'device/constants'

require_relative 'device/bmbt'
require_relative 'device/cdc'
require_relative 'device/diagnostics'
require_relative 'device/dsp'
require_relative 'device/gfx'
require_relative 'device/ike'
require_relative 'device/mfl'
require_relative 'device/radio'
require_relative 'device/tel'
require_relative 'device/tv'
