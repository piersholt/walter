# frozen_string_literal: true

puts "\tLoading wilhelm/virtual/device/augmented"

require_relative 'augmented/constants'

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
