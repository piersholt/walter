class Commands
  # ID: 26 0x1A
  class CCMDisplay < BaseCommand

    # Priority 1
    # These defects are immediately indi-
    # cated by a gong and a flashing warning symbol (1).
    # Simultaneous defects will be displayed consecutively.
    # These status reports remain in the display until the defects are corrected.
    # It is not pos- sible to delete them by pressing the CHECK button (3):

    # CCM	IKE	ALRT	[54 3]	"     LIGHTS ON      "
    # ARROW: 2 (FLASH), GONG: HIGH (DOUBLE)
    # POST TRIP

    # CCM	IKE	ALRT	[55 4]	" CHECK BRAKE LIGHTS "
    # ARROW: 0, GONG: HIGH
    # PRIORIY 2

    # CCM	IKE	ALRT	[55 16]	"   RANGE  24 KM     "
    # ARROW: 0: NO, GONG: LOW


    attr_accessor :mode, :control, :text

    def initialize(id, props)
      super(id, props)
      # LOGGER.warn props.to_s

      # @arguments mapped in super class
      @argument_map = map_arguments(@arguments)

      @mode = parse_mode(@argument_map[:mode])
      @control = parse_control(@argument_map[:control])
      @text = parse_text(@argument_map[:string])

      # @chars = parse_chars(@argument_map[:chars])
    end

    # def inspect
    #   # super handles from to command
    #   # this only appends arguments
    #   str_buffer = super
    #   # TODO: this needs to be a string, not have Chars print itself
    #   # puts @chars.overlay
    #   "[#{@arguments.map(&:h).join(' ')}]"
    # end

    # def to_s
    #   return inspect if @verbose
    #   "#{@short_name} (#{d})\t[#{@mode} #{@control}]\t\"#{@text}\""
    # end

    # def to_s
    #   if @verbose
    #     puts @chars.overlay
    #     "#{@short_name} (#{d})\t [#{@arguments.map(&:h).join(' ')}]"
    #   else
    #     "#{@short_name}\t \"#{@string}\""
    #   end
    # end

    private

    def map_arguments(arguments)
      { mode: arguments[0],
        control: arguments[1],
        string: arguments[2..-1] }
    end

    def parse_mode(mode_byte)
      mode_value = mode_byte.to_d
      @modes[mode_value]
      # mode_value
    end

    def parse_control(control_byte)
      control_value = control_byte.to_d
      @controls[control_value]
      # control_value
    end

    def parse_text(arguments)
      # binding.pry
      arguments.map do |byte|
        byte.to_d.chr
      end.join
    end

    def parse_text(arguments)
      Chars.new(arguments)
    end
  end
end
