# frozen_string_literal: false

# require 'daru'
require 'matrix'

# @deprecated
module Printable
  def self.included(mod)
    # raise ScriptError, "#{mod} is attempting to load deprecated module: Printable"
    puts "#{mod} is including #{self.class.name}"
  end

  attr_reader :matrix

  OUTPUT =
  { col_width: 5,
    label_width: 5,
    border_width: 1,
    col_border: '|',
    row_border: '-',
    axis: '+',
    space_char: ' ' }.freeze

  # def setup
  #   @index_sizes = { id: 5, timestamp: 10, message: 100 }
  # end

  # def to_s
  #   c.to_a.join
  # end

  #  -n length: Interpret only length bytes of input.
  #  -s offset: Skip offset bytes from the beginning of the input.
  # def overlay(overlay_length = length, overlay_offset = 0)
  #   @overlay_length = overlay_length
  #   @overlay_offset = overlay_offset
  #
  #   # number_of_rows = @matrix.column_vectors.size + 1
  #   rows = %i[hex integer char]
  #
  #   # Line 1 and 2
  #   if @overlay_length == length
  #     draw_header_line
  #     draw_column_headings
  #   else
  #     rows.unshift(:index, :sequence)
  #     # rows.unshift(:index)
  #   end
  #
  #   # Line 3 (header) and 4 (data)
  #   rows.each do |row_name|
  #     draw_header_line
  #     draw_data_line(row_name)
  #   end
  #
  #   # Line 5
  #   draw_footer
  # end

  def columns
    { index: 7, timestamp: 15, topic: 15, node: 15, type: 20, name: 30, properties: 50 }
  end

  def column_count
    columns.lenth
  end

  alias index_sizes columns

  private

  def draw_column_headings
    columns.each do |column_name, column_width|
      print OUTPUT[:col_border]
      # colums = index_sizes[index]
      # width = OUTPUT[:col_width] + ((column_width - 1) * (OUTPUT[:col_width] + 1))
      width = column_width
      index_label = column_name.upcase
      index_label_padded = index_label.to_s.prepend(' ')

      print format("%-#{width}.#{width}s", index_label_padded)
    end

    puts OUTPUT[:col_border]
  end

  def header
    h_div
    draw_column_headings
    h_div
  end

  def draw_message(message_hash)
    columns.each do |column_id, object|
      LOGGER.debug { "#draw_message(#{column_id}, #{object})" }
      print OUTPUT[:col_border]
      width = columns[column_id]
      draw_message_body(message_hash[:message], column_id) && next if message_columns.include?(column_id)
      string = message_hash[column_id]
      print format(" %-#{width - 1}.#{width - 1}s", string)
    end
    puts OUTPUT[:col_border]
  end

  def message_columns
    %i[topic name properties type node]
  end

  def draw_message_body(object, column_id)
    LOGGER.debug { "#draw_message_body(#{object}, #{column_id})" }
    # message_columns.each do |column_id|
      # next unless columns.key?(column_id)
      width = columns[column_id]
      LOGGER.debug { "#{column_id} width: #{width}" }
      string = object.public_send(column_id).to_s
      LOGGER.debug { "#{string}: #{string}" }
      LOGGER.debug { "#{string} length: #{string.length}" }
      print format(" %-#{width - 1}.#{width - 1}s", string)
      LOGGER.debug { "#{string} end!" }
    # end
  end

  # def draw_data_line(row_name)
  #   # draw_row_label(row_name)
  #
  #   @overlay_length.times do |index|
  #     print OUTPUT[:col_border]
  #     print draw_data(row_name, (index + @overlay_offset))
  #   end
  #
  #   puts OUTPUT[:col_border]
  # end

  def h_div
    # print OUTPUT[:col_border].to_s
    # OUTPUT[:label_width].times {|_| print OUTPUT[:row_border] }

    columns.each do |_, column_length|
      print OUTPUT[:axis]
      column_length.times { |_| print OUTPUT[:row_border] }
    end

    puts OUTPUT[:col_border]
  end

  # alias i integer
  # alias h hex
  # alias c char
  # alias t control
end
