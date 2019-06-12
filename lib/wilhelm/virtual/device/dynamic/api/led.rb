# class
#   class BMBT < BusDevice
#     include API::LED
#   end
# end

# bus.yaml
# :bmbt:
#   :api:
#     - :ping
#     - :led

module Wilhelm::Virtual::API
  module LED
    include Observable
    include Event
    # extend self

    COMMAND_ID = 0x2B

    Y = :yellow
    R = :red
    G = :green

    OFF = 0
    ON = 1
    BLINK = 2

    def green(state = ON)
      # get current state, then override green with this value
    end

    def set_all(options)
      command_arguments = parse_options(options)

      command = CommandMap.instance.find(COMMAND_ID, command_arguments)
      to = DeviceMap.instance.find(d)
      from = DeviceMap.instance.find(Devices::DSP)

      # mb = MessageBuilder.new
      # mb.from = from
      # mb.to = to
      # mb.command = command

      message = Message.new(from, to, command, arguments)

      changed
      notify_observers(MESSAGE_SENT, message: message)
    end

    private

    def parse_options(options)
      yellow = options[Y]
      red = options[R]
      green = options[G]

      Bytes.new([yellow, red, green])
    end
  end

  # module Ping
  #   def ping
  #   end
  # end
end

# class BUSDevice
#   include LED
# end

# module Emulate
#   # a module assumes there's a class
#   module Pong
#     def announce
#     end
#
#     def respond
#     end
#   end
# end
