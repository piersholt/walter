# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      # Device::Emulated
      class Emulated < Dynamic
        include Capabilities::Ready

        PROC = 'Device::Emulated'

        def initialize(args)
          super(args)
        end

        def type
          TYPE_EMULATED
        end

        # @override Object#inspect
        def inspect
          "#<Emulated :#{@ident}>"
        end

        # @override Device::Dynamic
        def handle_virtual_receive(message)
          command_id = message.command.d
          case command_id
          when PING
            pong
          when IGNITION_REP
            case message.command.position.ugly
            when :kl_30
              unannounce!
            when :kl_r
              announce unless announced?
            end
          end
        end
      end
    end
  end
end
