require 'commands/chars'

class Commands
  # 35 / 0x24
  class MediaDisplay < BaseCommand
    attr_accessor :text, :chars, :gfx, :ike

    def initialize(id, props)
      super(id, props)
      @argument_map = map_byte_stream(@arguments)
      @gfx = parse_gfx(@argument_map[:gfx])
      @ike = parse_ike(@argument_map[:ike])
      @text = parse_text(@argument_map[:text])
      # @chars = parse_chars(@argument_map[:chars])
    end

    def inspect
      # s_command = h
      # s_gfx = gfx.h
      # s_ike = ike.h
      # s_text = @text.h.to_a.join(' ')

      str_buffer = "#{h}\t#{@argument_map[:gfx].h} #{@argument_map[:ike].h}\t\"#{@text}\""
      str_buffer
    end

    def to_s
      command = sn
      text = @text.h.to_a.join(' ')
      str_buffer = "#{command}\t#{@gfx} | #{@ike}\t\"#{@text}\""
      str_buffer
    end

    # ------------------------------ PRINTABLE ------------------------------ #

    # TODO: probaby a way of using yield?
    def bytes
      b_gfx = @argument_map[:gfx]
      b_ike = @argument_map[:ike]
      b_text = @argument_map[:text]

      { GFX: b_gfx, IKE: b_ike, STRING: b_text }
    end

    private

    # ------------------------------ INITIALIZE ------------------------------ #

    def map_byte_stream(arguments)
      { gfx: arguments[0],
        ike: arguments[1],
        text: arguments[2..-1] }
    end

    def parse_gfx(variant_byte)
      sub_command_value = variant_byte.d
      human = @gfx[sub_command_value]
      human.nil? ? variant_byte.h : human
    end

    def parse_ike(variant_byte)
      sub_command_value = variant_byte.d
      human = @ike[sub_command_value]
      human.nil? ? variant_byte.h : human
    end

    def parse_text(arguments)
      Chars.new(arguments)
    end
  end
end
