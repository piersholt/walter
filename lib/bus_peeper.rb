require 'serialport'
require 'pry'

# @deprecated
# BusPeeper
class BusPeeper
  PORT = '/dev/cu.SLAB_USBtoUART'
  PORT_PARAMS = { "baud" => 9600, "data_bits" => 8, "stop_bits" => 1, "parity" => 2 }

  attr_reader :sp

  def initialize
    serial_port = SerialPort.new(PORT, PORT_PARAMS)
    serial_port.flow_control = SerialPort::HARD
    # serial_port.read_timeout = 10

    @sp = serial_port
  end

  def run
    messages = []
    sp.flush_input
    last_message = ''

    while messages.size < 100 do
        puts "Buffering message ##{messages.size}"
        last_message = sp.readpartial(255)
        messages << last_message
        puts "Loaded message ##{messages.size}"
    end

    messages
  end
end
