class Commands
  # ID: 17 0x11
  class Ignition < BaseCommand
    attr_accessor :v1

    VALUE_MAP = { ignition: :v1 }.freeze

    def initialize(id, props)
      super(id, props)
      @argument_map = map_arguments(@arguments)

      @v1 = parse_bytes(@argument_map[:ignition])
    end

    # ---- Interface ---- #

    # def ambient
    #   @v1
    # end
    
    # def coolant
    #   @v2
    # end

    # ---- Printable ---- #

    def bytes
      { ignition: @argument_map[:ignition] }
    end

    # ---- Core ---- #

    # @override
    def to_s
      str_buffer = "#{sn}\tIgnition: #{v1}"
      str_buffer
    end

    def inspect
      str_buffer = "#{sn}\tIgnition: #{v1}"
      str_buffer
    end

    # def argument_map
    #   @argument_map ||= {}
    # end

    private

    def map_arguments(arguments)
      # first = @ignition[:index][:start]
      # last = @ignition[:index][:end]

      { ignition: arguments[0] }
    end

    def parse_bytes(value)
      @ignition[value.d]
    end
  end
end
