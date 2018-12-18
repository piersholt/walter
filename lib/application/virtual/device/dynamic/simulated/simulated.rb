root = 'application/virtual/device/dynamic/simulated'

require "#{root}/common/alive"
require "#{root}/common/stateful"

require "#{root}/device"

require "#{root}/cdc/changer_request"
require "#{root}/cdc/cdc"

require "#{root}/dsp/dsp"

require "#{root}/tel/handlers"
require "#{root}/tel/tel"

require "#{root}/diagnostics/device"
