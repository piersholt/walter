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

    def matches
      @matches ||= {}
    end

    def not_subset?(segment_length, segment_start)
      return true
      matches[segment_length]
    end

    def duplicates
      LOGGER.debug(self.class.name) { "#duplicates()" }
      segment_length = 11
      while segment_length >= 8 do
        LOGGER.debug(self.class.name) { "segment_length => #{segment_length}" }
        matches[segment_length] = []
        segment_start = 0
        segment = bytes[segment_start, segment_length]
        while segment.length == segment_length do
          LOGGER.debug(self.class.name) { "\tsegment_start => [#{segment_start}, #{segment_length}]" }
          other_segment_start = segment_start + segment_length
          # matches.fetch(segment_length)[segment] = 0
          # this_segment_count = matches.fetch(segment_length)[segment]
          # bytes.slice(other_segment_start..-1).each_slice(segment_length) do |slice|
          #   result = segment.eql?(slice)
          #   if result && not_subset?(segment_length, segment_start)
          #     this_segment_count += 1
              # matches << { segment_length: segment_length, segment_start: segment_start, other_segment_start: other_segment_start }
              # matches.fetch(segment_length) << [(segment_start..(segment_start + segment_length - 1)), (other_segment_start..(other_segment_start + segment_length - 1))]
              # LOGGER.debug(self.class.name) { "\t\t\tResult! segment_length: #{segment_length}, segment_start: #{segment_start}, other_segment_start: #{other_segment_start}" }
          #   end
          # end
          other_segment = bytes[other_segment_start, segment_length]
          while other_segment.length == segment_length do
            LOGGER.debug(self.class.name) { "\t\tother_segment_start => [#{other_segment_start}, #{segment_length}]" }
            LOGGER.debug(self.class.name) { "\t\t\t#{segment} == #{other_segment}" }
            result = segment.eql?(other_segment)
            if result && not_subset?(segment_length, segment_start)
              # matches << { segment_length: segment_length, segment_start: segment_start, other_segment_start: other_segment_start }
              matches.fetch(segment_length) << [(segment_start..(segment_start + segment_length - 1)), (other_segment_start..(other_segment_start + segment_length - 1))]
              LOGGER.debug(self.class.name) { "\t\t\tResult! segment_length: #{segment_length}, segment_start: #{segment_start}, other_segment_start: #{other_segment_start}" }
            end
            other_segment_start += 1
            other_segment = bytes[other_segment_start, segment_length]
          end
          segment_start += 1
          segment = bytes[segment_start, segment_length]
        end
        segment_length -= 1
        segment_start = 0
        other_segment_start = segment_start + segment_length
      end

      # longest_matchs = matches.find { |_, objects| objects.length > 0 }
      matches.each do |length, ranges|
        LOGGER.info(self.class.name) { "Length: #{length}" }
        highlight(*ranges)
      end
      # longest_range_pairs = longest_matchs[1]
      # highlight(*longest_range_pairs)
      true
    end

    def highlight(*ranges)
      LOGGER.debug(self.class.name) { "#highlight(#{ranges})" }
      ranges.each do |r1, r2|
        LOGGER.debug(self.class.name) { "r1 => #{r1}, r2 => #{r2}" }
        prefix_range = prefix(r1.first)
        r1_range = subset(r1)
        middle_range = subset((r1.last + 1)..(r2.first - 1))
        r2_range = subset(r2)
        suffix_range = suffix(r2.last)

        LOGGER.info(self.class.name) do
          "#{gray}#{to_s(prefix_range)}#{fuck_off}"\
          "#{green}#{to_s(r1_range)}#{fuck_off}"\
          "#{gray}#{to_s(middle_range)}#{fuck_off}"\
          "#{red}#{to_s(r2_range)}#{fuck_off}"\
          "#{gray}#{to_s(suffix_range)}#{fuck_off}"
        end
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
        return '' unless array
        return '' if array.empty?
        i + '' + array.join(' ') + ' '
      end
    end
  end
end
