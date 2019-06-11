# frozen_string_literal: false

class Wernher
  # Comment
  class Transmission
    include LogActually::Formatter
    attr_reader :bytes

    def initialize(array = [])
      @bytes = array
    end

    def index(range)
      indexes << range
    end

    def clear
      @indxes = []
    end

    def indexes
      @indexes ||= []
    end

    def indexed
      indexes.each do |range|
        puts subset(range).join(' ')
      end
    end

    def duplicates
      LOGGER.debug(self.class.name) { "#duplicates()" }
      (0..length).each do |start_index|
        start_offset = start_index + 1
        last_index = length - 2
        (start_offset..last_index).each do |stop_index|
          target_range = subset(start_index..stop_index)
          duplicate_result = find_duplicate(start_index, stop_index)
          do_something_with_result(start_index, stop_index, checksum) if checksum_result
        end
      end
    end

    def find_duplicate(start_index, stop_index)
      LOGGER.debug(self.class.name) { "#find_duplicate(#{start_index}, #{stop_index}, #{checksum})" }
      checksum_byte = ByteBasic.new(checksum, :integer)
      next_byte(stop_index).any? do |i|
        test(i, checksum_byte)
      end

    end

    def checksums
      LOGGER.debug(self.class.name) { "#checksums()" }
      (0..length).each do |start_index|
        start_offset = start_index + 1
        last_index = length - 2
        (start_offset..last_index).each do |stop_index|
          target_range = subset(start_index..stop_index)
          checksum = calculate_checksum(start_index, stop_index)
          checksum_result = search_checksum(start_index, stop_index, checksum)
          do_something_with_result(start_index, stop_index, checksum) if checksum_result
        end
      end
    end

    def do_something_with_result(start_index, stop_index, checksum)
      prefix_range = prefix(start_index)
      target_range = subset(start_index..stop_index)
      suffix_range = suffix(stop_index)
      checksum_range = next_byte(stop_index)
      checksum_suffix = suffix(stop_index + 1)
      checksum_byte = ByteBasic.new(checksum, :integer)

      LOGGER.debug(self.class.name) { 'Match!' }
      LOGGER.debug(self.class.name) { "Unformatted\t: #{to_s(prefix_range, target_range, suffix_range)}" }
      LOGGER.info(self.class.name) do
        "Formatted\t: "\
        "#{gray}#{to_s(prefix_range)}#{fuck_off}"\
        "#{green}#{to_s(target_range)}#{fuck_off}"\
        "#{red}#{to_s(checksum_range)}#{fuck_off}"\
        "#{gray}#{to_s(checksum_suffix)}#{fuck_off}"

      end
      LOGGER.debug(self.class.name) { "Target Range: #{target_range}, #{checksum_byte}" }
      LOGGER.debug(self.class.name) { "Suffix Range: #{next_byte(stop_index)}" }
      LOGGER.debug(self.class.name) { "#{to_s(target_range, next_byte(stop_index))}" }
    end

    def test(byte_1, byte_2)
      LOGGER.debug(self.class.name) { "#test(#{byte_1}, #{byte_2})" }
      result = byte_1.eql?(byte_2)
      LOGGER.debug(self.class.name) { "#{byte_1}.eql?(#{byte_2}) => #{result}" }
      result
    end

    def search_checksum(start_index, stop_index, checksum)
      LOGGER.debug(self.class.name) { "#search_checksum(#{start_index}, #{stop_index}, #{checksum})" }
      checksum_byte = ByteBasic.new(checksum, :integer)
      next_byte(stop_index).any? do |i|
        test(i, checksum_byte)
      end

    end

    def calculate_checksum(start_index, stop_index)
      LOGGER.debug(self.class.name) { "#calculate_checksum(#{start_index}, #{stop_index})" }
      target_range = subset(start_index..stop_index)
      result = target_range.reduce(0) { |i, byte_object| i ^ byte_object.to_i }
      LOGGER.debug(self.class.name) do
        "Checksum: " \
        "#{to_s(prefix(start_index))} "\
        "#{green}#{to_s(target_range)}#{clear}} "\
        "#{red}#{to_s(suffix(stop_index))} "\
        "=> #{result}"
      end
      result
    end

    def length
      bytes.length
    end

    def subset(range)
      bytes[range]
    end

    def prefix(start_index)
      subset(0..(start_index - 1))
    end

    def suffix(stop_index)
      subset((stop_index + 1)..-1)
    end

    def next_byte(stop_index)
      bytes[stop_index + 1, 1]
    end

    def to_s(*arrays)
      arrays.reduce('') do |i, array|
        i + '' + array.join(' ') + ' '
      end
    end
  end
end
