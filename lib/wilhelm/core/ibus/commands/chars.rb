# require 'daru'
require 'matrix'

class Wilhelm::Core::Command
  class Chars
    # COLUMN_COUNT = 3
    COLUMN_MAP = { integer: 0, hex: 1, char: 2, control: 3 }
    # COLUMNS = [:integer, :hex, :char]

    attr_reader :matrix

    OUTPUT =
    { col_width: 5,
      label_width: 10,
      border_width: 1,
      col_div: '|',
      row_div: '-',
      space_char: ' ' }.freeze

    def initialize(byte_array, format = false)
      byte_array = byte_array.map {|i| Wilhelm::Core::Byte.new(:decimal, i) } if format
      @byte_array = byte_array
      parse_arguments(byte_array)
    end

    def parse_arguments(byte_array)
      rows = parse_byte_array(byte_array)
      @matrix = Matrix.rows(rows)
    end

    def index
      @index ||= Array.new(length) {|i| i }
    end

    def integer
      @matrix.column(COLUMN_MAP[:integer])
    end

    def hex
      @matrix.column(COLUMN_MAP[:hex])
    end

    def char
      @matrix.column(COLUMN_MAP[:char])
    end

    def control
      @matrix.column(COLUMN_MAP[:control])
    end

    def length
      i.size
    end

    def controls
      control_chars = []
      integer.map do |i|
        case i
        when (0..31)
          control_chars << i
        when (128..255)
          control_chars << i
        end
      end
      control_chars
    end

    def reload!
      parse_arguments(@byte_array)
    end

    def to_s
      c.to_a.join
    end

    # index row
    # integer
    # hex
    # char row
    # control
    def overlay
      # number_of_columns = length
      number_of_rows = @matrix.column_vectors.size + 1

      # rows = [:index, :integer, :hex, :char, :control]
      # rows = [:index, :hex, :integer, :char, :control]
      rows = [:hex, :integer, :char, :control]

      draw_header_line

      rows.each do |row_name|
        draw_row(row_name)
      end

      draw_footer
    end

    def draw_row(row_name)
      # draw_header_line
      draw_data_line(row_name)
    end

    def draw_data_line(row_name)
      draw_row_label(row_name)

      length.times do |index|
        print OUTPUT[:col_div]
        print draw_data(row_name, index)
      end

      puts OUTPUT[:col_div]
    end

    def draw_row_label(row_name)
      print OUTPUT[:col_div]

      output_chars = row_name.to_s.chars

      padding = OUTPUT[:label_width] - row_name.length

      overflow = padding.modulo(2)
      padding -= overflow

      left_padding = padding.div(2)
      right_padding = left_padding + overflow
      # right_padding = padding - left_padding

      left_padding.times { |_| output_chars.unshift(' ') }
      right_padding.times { |_| output_chars.push(' ') }

      print output_chars.join
    end

    def draw_data(row_name, index)
      output = public_send(row_name)[index]

      output_chars = output.to_s.chars

      # LOGGER.info(output_chars.to_s)

      left_padding = output_chars.length > 1 ? 1 : 2
      left_padding.times {|_| output_chars.unshift(' ') }

      right_padding = output_chars.length > 3 ? 1 : 2
      right_padding.times {|_| output_chars.push(' ') }

      # LOGGER.info(output_chars.to_s)

      # chars = Array.new(OUTPUT[:col_width], OUTPUT[:space_char])
      # chars[2] = output

      output_chars.join
    end

    def draw_header_line
      print OUTPUT[:col_div].to_s
      OUTPUT[:label_width].times {|_| print OUTPUT[:row_div] }

      length.times do |i|
        print OUTPUT[:col_div]
        OUTPUT[:col_width].times {|_| print OUTPUT[:row_div] }
      end
      puts OUTPUT[:col_div]
    end

    def draw_footer
      draw_header_line
    end

    alias i integer
    alias h hex
    alias c char
    alias t control

    private

    def parse_byte_array(bytes)
      bytes.map do |byte|
        integer = byte.to_d
        hex = Wilhelm::Helpers::DataTools.decimal_to_hex(integer)
        # char =

        thingo = case integer
        when (0..31)
          ['☐', '✗']
        when (128..255)
          ['☐', '✗']
        else
          [integer.chr(Wilhelm::Helpers::DataTools::BINARY_ENCODING), ' ']
        end

        char = thingo[0]
        control = thingo[1]

        [integer, hex, char, control]
      end
    end
  end
end
