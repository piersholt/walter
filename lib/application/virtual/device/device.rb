# frozen_string_literal: true

root = 'application/virtual/device'

require "#{root}/receivable"
# require "#{root}/stateful"

require "#{root}/broadcast"
require "#{root}/devices"

require "#{root}/capabilities/helpers"
require "#{root}/capabilities/alive"
require "#{root}/capabilities/diagnostics/gm"
require "#{root}/capabilities/diagnostics/lcm"
require "#{root}/capabilities/diagnostics"

require "#{root}/capabilities/bmbt"
require "#{root}/capabilities/radio"

require "#{root}/dynamic/dynamic"
require "#{root}/augmented/augmented"
require "#{root}/simulated/simulated"

# Comment
class Virtual
  class Device
    include Observable
    include Receivable

    PROC = 'Device'.freeze

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
end
