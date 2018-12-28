root = 'application/virtual/device/capabilities'

require "#{root}/helpers"

require "#{root}/ready"

require "#{root}/diagnostics/gm"
require "#{root}/diagnostics/lcm"
require "#{root}/diagnostics"

require "#{root}/radio/cd_changer_control"
require "#{root}/radio/cd_changer_display"
require "#{root}/radio/radio_display"
require "#{root}/radio/nav_display"
require "#{root}/radio/user_interface"
require "#{root}/radio"

require "#{root}/cdc/constants"
require "#{root}/cdc/chainable"
require "#{root}/cdc/state"
require "#{root}/cdc"

require "#{root}/gfx/user_interface"
require "#{root}/gfx"

require "#{root}/bmbt/constants"
require "#{root}/bmbt/user_controls"
require "#{root}/bmbt"
