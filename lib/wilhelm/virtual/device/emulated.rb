# frozen_string_literal: true

puts "\tLoading wilhelm/virtual/device/emulated"

# Base
require_relative 'emulated/device'

# CDC
require_relative 'emulated/cdc/handlers'
require_relative 'emulated/cdc/device'

# DSP
require_relative 'emulated/dsp/device'

# Radio
require_relative 'emulated/rad/device'

# Telephone
require_relative 'emulated/tel/state/model'
require_relative 'emulated/tel/state/chainable'
require_relative 'emulated/tel/state'
require_relative 'emulated/tel/received'
require_relative 'emulated/tel/handlers'
require_relative 'emulated/tel/device'

# Diagnostics
require_relative 'emulated/diagnostics/device'

# Dummy
require_relative 'emulated/dummy/device'
