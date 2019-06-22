# frozen_string_literal: true

puts "\tLoading wilhelm/virtual/device/dynamic/capabilities"

require_relative 'capabilities/helpers'

require_relative 'capabilities/ready'

require_relative 'capabilities/diag/gm'
require_relative 'capabilities/diag/lcm'
require_relative 'capabilities/diag'

require_relative 'capabilities/gfx/constants'
require_relative 'capabilities/gfx/user_interface'
require_relative 'capabilities/gfx/user_controls'
require_relative 'capabilities/gfx/obc'
require_relative 'capabilities/gfx'

require_relative 'capabilities/mfl/constants'
require_relative 'capabilities/mfl/buttons'
require_relative 'capabilities/mfl'

require_relative 'capabilities/radio/constants'
require_relative 'capabilities/radio/cd_changer_control'
require_relative 'capabilities/radio/cd_changer_display'
require_relative 'capabilities/radio/radio_display'
require_relative 'capabilities/radio/rds_display'
require_relative 'capabilities/radio/user_interface'
require_relative 'capabilities/radio/led'
require_relative 'capabilities/radio'

require_relative 'capabilities/tel/constants'
require_relative 'capabilities/tel/directory'
require_relative 'capabilities/tel/info'
require_relative 'capabilities/tel/led'
require_relative 'capabilities/tel'
