class Command
  # ID: 26 0x1A
  class Pong < BaseCommand

    attr_accessor :status

    def initialize(id, props)
      super(id, props)
      # LOGGER.warn props.to_s

      # @arguments mapped in super class
      @argument_map = map_arguments(@arguments)

      @status = parse_status(@argument_map[:status])
    end

    def to_s
      command = sn
      str_buffer = "#{command}\t#{@status}"
      str_buffer
    end

    def inspect
      command = sn
      str_buffer = "#{command}\t#{@argument_map[:status]}"
      str_buffer
    end

    def alt?
      @argument_map[:status].d >= '0x40'.hex
    end

    private

    def map_arguments(arguments)
      { status: arguments[0] }
    end

    def parse_status(status_byte)
      # LOGGER.warn status_byte.d
      # LOGGER.warn @status
      status_value = status_byte.d
      @status_map[status_value]
      # status_value
    end
  end
end
