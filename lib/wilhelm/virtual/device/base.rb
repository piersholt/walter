# frozen_string_literal: true

# Comment
class Wilhelm::Virtual
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
end
