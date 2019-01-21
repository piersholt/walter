# frozen_string_literal: true

root = 'application/virtual/device/dynamic/augmented'

require "#{root}/device"

# Radio
radio_root = root + '/radio'
require "#{radio_root}/state/constants"
require "#{radio_root}/state/model"
require "#{radio_root}/state/chainable"
require "#{radio_root}/state"
require "#{radio_root}/actions"
require "#{radio_root}/notifications"
require "#{radio_root}/device"

# Radio
gfx_root = root + '/gfx'
require "#{gfx_root}/state/constants"
require "#{gfx_root}/state/model"
require "#{gfx_root}/state/chainable"
require "#{gfx_root}/state/sent"
require "#{gfx_root}/state/received"
require "#{gfx_root}/state"
require "#{gfx_root}/device"
