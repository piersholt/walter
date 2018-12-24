root = 'application/virtual/device/dynamic/emulated'

require "#{root}/common/alive"

require "#{root}/device"

require "#{root}/cdc/handlers"
require "#{root}/cdc/device"

require "#{root}/dsp/device"

require "#{root}/tel/handlers"
require "#{root}/tel/device"

require "#{root}/diagnostics/device"

require "#{root}/dummy/device"
