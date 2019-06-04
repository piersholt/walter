# frozen_string_literal: true

puts "\tLoading walter-virtual/device"

device_root = 'device'
require "#{device_root}/events"
require "#{device_root}/receivable"
require "#{device_root}/base"

puts "\tLoading walter-virtual/device/dynamic"

require "#{device_root}/api/api"
require "#{device_root}/capabilities/capabilities"
require "#{device_root}/device_builder"
require "#{device_root}/dynamic"

# AUGMENTED -------------------------------------------------------------------

puts "\tLoading walter-virtual/device/augmented"

augmented_root = 'device/augmented'

require "#{augmented_root}/device"

# Radio
radio_root = augmented_root + '/radio'
require "#{radio_root}/state/constants"
require "#{radio_root}/state/model"
require "#{radio_root}/state/chainable"
# require "#{radio_root}/state/sent"
require "#{radio_root}/state/received"
require "#{radio_root}/state"
require "#{radio_root}/actions"
require "#{radio_root}/notifications"
require "#{radio_root}/device"

# Radio
gfx_root = augmented_root + '/gfx'
require "#{gfx_root}/state/constants"
require "#{gfx_root}/state/model"
require "#{gfx_root}/state/chainable"
require "#{gfx_root}/state/sent"
require "#{gfx_root}/state/received"
require "#{gfx_root}/state"
require "#{gfx_root}/device"

# BMBT
bmbt_root = augmented_root + '/bmbt'
# require "#{bmbt_root}/state/constants"
# require "#{bmbt_root}/state/model"
# require "#{bmbt_root}/state/chainable"
# require "#{bmbt_root}/state/sent"
# require "#{bmbt_root}/state/received"
require "#{bmbt_root}/sent"
require "#{bmbt_root}/device"

# MFL
mfl_root = augmented_root + '/mfl'
require "#{mfl_root}/state/constants"
require "#{mfl_root}/state/model"
require "#{mfl_root}/state/chainable"
require "#{mfl_root}/state/sent"
# require "#{mfl_root}/state/received"
require "#{mfl_root}/state"
require "#{mfl_root}/device"

# EMULATED --------------------------------------------------------------------

puts "\tLoading walter-virtual/device/emulated"

emualted_root = 'device/emulated'

require "#{emualted_root}/common/alive"

require "#{emualted_root}/device"

require "#{emualted_root}/cdc/handlers"
require "#{emualted_root}/cdc/device"

require "#{emualted_root}/dsp/device"

require "#{emualted_root}/rad/device"

# Telephone
tel_root = emualted_root + '/tel'
require "#{tel_root}/constants"
require "#{tel_root}/state/model"
require "#{tel_root}/received"
require "#{tel_root}/handlers"
require "#{tel_root}/device"

require "#{emualted_root}/diagnostics/device"

require "#{emualted_root}/dummy/device"

puts "\tLoading walter-virtual/bus"
