# require 'daru'
require 'matrix'

module Printable
  COLUMN_MAP = { integer: 0, hex: 1, char: 2, control: 3, index: 4, sequence: 5 }
  COLUMN_ABVR_MAP = { integer: 'd', hex: '0x', char: 'chr', control: 'T', index: '', sequence: 'i' }

  attr_reader :matrix

  OUTPUT =
  { col_width: 5,
    label_width: 5,
    border_width: 1,
    col_border: '|',
    row_border: '-',
    axis: '+',
    space_char: ' ' }.freeze

  def parse_mapped_bytes(index_bytes_hash)
    @index_bytes_hash = index_bytes_hash
    @indexes = index_bytes_hash.keys
    @index_sizes = {}
    @sequence = 0

    rows_with_index = index_bytes_hash.map do |index, bytes|
      return_value = nil
      num_of_values = 1
      if bytes.respond_to?(:length)
        return_value = parse_bytes(index, bytes)
        num_of_values = bytes.length
      else
        return_value = parse_byte(index, bytes)
        return_value = [return_value]
      end

      @index_sizes[index] = num_of_values
      return_value
    end

    rows_with_index.flatten!(1)

    @matrix = Matrix.rows(rows_with_index)
    seq = Array.new(length) {|i| i }

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

  def index
    @matrix.column(COLUMN_MAP[:index])
  end

  def sequence
    @matrix.column(COLUMN_MAP[:sequence])
  end

  # The number of rows in the vectors
  def length
    integer.size
  end

  def reload!
    parse_arguments(@byte_array)
  end

  def to_s
    c.to_a.join
  end

  #  -n length: Interpret only length bytes of input.
  #  -s offset: Skip offset bytes from the beginning of the input.
  def overlay(overlay_length = length, overlay_offset = 0)
    @overlay_length = overlay_length
    @overlay_offset = overlay_offset

    # number_of_rows = @matrix.column_vectors.size + 1
    rows = %i(hex integer char)

    # Line 1 and 2
    if @overlay_length == length
      draw_header_line
      draw_column_headings
    else
      rows.unshift(:index, :sequence)
      # rows.unshift(:index)
    end

    # Line 3 (header) and 4 (data)
    rows.each do |row_name|
      draw_header_line
      draw_data_line(row_name)
    end

    # Line 5
    draw_footer
  end

  private

  def parse_bytes(index, bytes)
    bytes.map do |byte|
      parse_byte(index, byte)
    end
  end

  def parse_byte(index, byte)
    integer = byte.to_d
    hex = DataTools.decimal_to_hex(integer)
    # char =

    thingo =
      case integer
      when (0..31)
        ['☐', '✗']
      when (128..255)
        ['☐', '✗']
      else
        [integer.chr(DataTools::BINARY_ENCODING), ' ']
      end

    char = thingo[0]
    control = thingo[1]

    seq = @sequence
    @sequence += 1

    [integer, hex, char, control, index, seq]
  end

  # @deprecated
  # def draw_row(row_name)
  #   draw_header_line
  #   draw_data_line(row_name)
  # end

  def draw_column_headings
    # draw_row_label(:heading)

    # LOGGER.warn(@index_sizes)

    @index_sizes.each do |index, columns|
      print OUTPUT[:col_border]
      # colums = @index_sizes[index]
      width = OUTPUT[:col_width] + ((columns - 1) * (OUTPUT[:col_width] + 1))
      index_label = index.upcase
      index_label_padded = index_label.to_s.prepend(' ')

      print sprintf("%-#{width}.#{width}s", index_label_padded)
    end

    puts OUTPUT[:col_border]
  end

  def draw_data_line(row_name)
    # draw_row_label(row_name)

    @overlay_length.times do |index|
      print OUTPUT[:col_border]
      print draw_data(row_name, (index + @overlay_offset))
    end

    puts OUTPUT[:col_border]
  end

  def draw_row_label(row_name)
    print OUTPUT[:col_border]

    abvr = COLUMN_ABVR_MAP[row_name]

    output_chars = abvr.to_s.chars

    padding = OUTPUT[:label_width] - row_name.length

    overflow = padding.modulo(2)
    padding -= overflow

    left_padding = padding.div(2)
    right_padding = left_padding + overflow
    # right_padding = padding - left_padding

    left_padding.times { |_| output_chars.unshift(' ') }
    right_padding.times { |_| output_chars.push(' ') }

    # print output_chars.join

    w = OUTPUT[:label_width]
    print sprintf("%#{w}.#{w}s"," #{abvr} ")
  end

  def draw_data(row_name, index)
    output = public_send(row_name)[index]

    output_chars = output.to_s.chars

    if output_chars.length > 3
      output_chars = output_chars[0..2]
    end

    # LOGGER.info(output_chars.to_s)

    left_padding = output_chars.length > 1 ? 1 : 2
    left_padding.times { |_| output_chars.unshift(' ') }

    right_padding = output_chars.length > 3 ? 1 : 2
    right_padding.times { |_| output_chars.push(' ') }

    # LOGGER.info(output_chars.to_s)

    # chars = Array.new(OUTPUT[:col_width], OUTPUT[:space_char])
    # chars[2] = output

    output_chars.join
  end

  def h_div
    # print OUTPUT[:col_border].to_s
    # OUTPUT[:label_width].times {|_| print OUTPUT[:row_border] }

    @overlay_length.times do |i|
      print OUTPUT[:axis]
      OUTPUT[:col_width].times { |_| print OUTPUT[:row_border] }
    end

    puts OUTPUT[:col_border]
  end

  # @deprecated
  def draw_header_line
    h_div
  end

  # @deprecated
  def draw_footer
    h_div
  end

  alias i integer
  alias h hex
  alias c char
  alias t control

end
