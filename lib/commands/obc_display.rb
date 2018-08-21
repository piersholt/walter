class Commands
  # ID: DECIMAL? HEX?
  class OBCDisplay < BaseCommand
    # Arguments Map
    # 0: Mode
    # 1: Control
    # 2+: Text

    attr_accessor :mode, :control, :text, :chars

    def initialize(id, props)
      super(id, props)

      # @arguments = props[:arguments]
      @argument_map = map_byte_stream(@arguments)

      @mode = parse_mode(@argument_map[:mode])
      @control = parse_control(@argument_map[:control])
      @chars = parse_chars(@argument_map[:chars])
    end

    # def to_s
    #   if @verbose
    #     puts @chars.overlay
    #     "#{@short_name} (#{d})\t [#{@arguments.map(&:h).join(' ')}]"
    #   else
    #     "#{@short_name}\t#{@mode} \"#{@text}\""
    #   end
    # end

    def inspect
      command = sn
      text = @chars.to_s
      str_buffer = "#{command}\t#{@mode} #{@control}\t\"#{@text}\""
      str_buffer
    end


    private

    def map_byte_stream(arguments)
      { mode: arguments[0],
        control: arguments[1],
        chars: arguments[0..-1] }
    end

    def parse_mode(mode_byte)
      mode_value = mode_byte.to_d
      @modes[mode_value]
    end

    def parse_control(control_byte)
      control_value = control_byte.to_d
    end

    def parse_chars(arguments)
      Chars.new(arguments)
    end
  end
end
