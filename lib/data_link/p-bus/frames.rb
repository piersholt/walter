module PBus
  class Frames
    extend Forwardable

    INDEX_COMMAND = 0

    FORWARD_MESSAGES = %i[<< push first last each empty? size sort_by length to_s count [] find_all find each_with_index find_index map group_by delete_at].freeze
    # SEARCH_PROPERTY = [:command_id, :from_id, :to_id].freeze

    FORWARD_MESSAGES.each do |method_name|
      def_delegator :@frames, method_name
    end

    def initialize(frames = [])
      @frames = frames
    end

    def inspect
      str_buffer = "\n"
      result = @frames.map do |m|
        m.inspect
      end.join("\n")

      str_buffer.concat(result)
    end

    # QUERY

    def command(*values)
      results = where(:command, *values)
      self.class.new(results)
    end

    def length(i)
      results = length_groups[i]
      self.class.new(results)
    end

    # ANALYSIS

    def commands
      result = @frames.map { |frame| frame[INDEX_COMMAND] }
      result = unique_bytes(result)
      result.sort
    end

    def lengths
      @frames.map { |message| message.length }.uniq
    end

    def group_by_header
      @frames.group_by do |frame|
        header_length = frame[1]
        frame_length = frame.length
        header_length.value == frame_length
      end
    end

    def header(boolean)
      results = group_by_header
      self.class.new(results[boolean])
    end

    def column_values(index)
      result = column(index)
      result = unique_bytes(result)
      result.sort
    end

    def vehicle_control
      result = @frames.find_all do |frame|
        frame[2].value == 0x0C
      end

      result = result.sort do |f1, f2|
        f1[3] <=> f2[3]
      end

      result = result.sort do |f1, f2|
        f1[0] <=> f2[0]
      end

      result
    end

    def diagnostics
      result = @frames.find_all do |frame|
        frame[1].value == frame.length
      end

      results = result.sort do |f2, f1|
        f1.length <=> f2.length
      end

      results = result.sort do |f1, f2|
        f1[0] <=> f2[0]
      end

      results
    end

    # SEARCH

    def where(property, *criteria)
      case property
      when :command
        @frames.find_all do |frame|
          command_value = frame[INDEX_COMMAND]
          criteria.any? { |criterion| criterion == command_value.value }
        end
      end
    end

    def column(index)
      @frames.map { |frame| frame[index] }
    end

    def length_groups
      @frames.group_by { |message| message.length }
    end

    def unique_bytes(array)
      array.uniq { |byte_basic| byte_basic.value }
    end
  end
end
