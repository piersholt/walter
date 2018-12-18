# frozen_string_literal: true

root = 'application/virtual/device'

api = "#{root}/api"
require "#{api}/api"

require "#{root}/receivable"

# require "#{root}/broadcast"

require "#{root}/capabilities/helpers"
require "#{root}/capabilities/ready"
require "#{root}/capabilities/diagnostics/gm"
require "#{root}/capabilities/diagnostics/lcm"
require "#{root}/capabilities/diagnostics"

require "#{root}/capabilities/bmbt"
require "#{root}/capabilities/radio"

require "#{root}/dynamic/dynamic"

# Comment
class Virtual
  class Device
    include Observable
    include Receivable

    PROC = 'Device'

    attr_reader :ident

    alias_method :me, :ident

    def initialize(device_ident)
      @ident = device_ident
    end

    def i_am(other)
      ident == other
    end

    def type
      :dumb
    end

    # @override Object#inspect
    def inspect
      "#<Device :#{@ident}>"
    end

    # @override Object#to_s
    def to_s
      "<:#{@ident}>"
    end
  end

  # Comment
  class BroadcastDevice < Device
    PROC = 'BroadcastDevice'

    def type
      :broadcast
    end
  end
end
