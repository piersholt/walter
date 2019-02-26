# require 'application/virtual/stateful'
# require 'application/virtual/alive'
# require 'application/virtual/cd'
# require 'application/virtual/telephone'

class Virtual
  class EmulatedDevice < DynamicDevice
    include Capabilities::Ready

    PROC = 'EmulatedDevice'.freeze

    def initialize(args)
      super(args)
    end

    def type
      :simulated
    end

    # @override Object#inspect
    def inspect
      "#<EmulatedDevice :#{@ident}>"
    end

    # @override Object#to_s
    def to_s
      "<:#{@ident}>"
    end

    # @override Virtual::Device#receive_packet

    def handle_virtual_receive(message)
      # logger.fatal(PROC) { "handle_virtual_receive: #{message.command.d}" }
      command_id = message.command.d
      case command_id
      when PING
        # logger.fatal(PROC) { "Rx: Handling: PING" }
        pong
      end
    end

    def handle_virtual_transmit(message)
      false
    end
  end
end
