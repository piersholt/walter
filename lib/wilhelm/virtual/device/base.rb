# frozen_string_literal: true

module Wilhelm
  module Virtual
    # Comment
    class Device
      class Base
        include Observable

        PROC = 'Device::Base'

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
          "#<Base :#{@ident}>"
        end

        # @override Object#to_s
        def to_s
          "<:#{@ident}>"
        end

        def virtual_receive(message)
          message
        end

        def virtual_transmit(message)
          message
        end
      end
    end
  end
end
