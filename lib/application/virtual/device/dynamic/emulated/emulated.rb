root = 'application/virtual/device/dynamic/emulated'

require "#{root}/common/alive"
require "#{root}/common/stateful"

require "#{root}/device"

require "#{root}/cdc/changer_request"
require "#{root}/cdc/device"

require "#{root}/dsp/device"

require "#{root}/tel/handlers"
require "#{root}/tel/device"

require "#{root}/diagnostics/device"
