root = 'application/virtual/device/capabilities'

require "#{root}/helpers"

require "#{root}/ready"

require "#{root}/diagnostics/gm"
require "#{root}/diagnostics/lcm"
require "#{root}/diagnostics"

require "#{root}/radio/cd_changer_control"
require "#{root}/radio/cd_changer_display"
require "#{root}/radio/user_interface"
require "#{root}/radio"

require "#{root}/bmbt/constants"
require "#{root}/bmbt/user_controls"
require "#{root}/bmbt"
