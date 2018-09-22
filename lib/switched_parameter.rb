# This needs the :state and :label property of this specific parameter
class SwitchedParameter < CommandParameter
  PROC = 'SwitchedParameter'.freeze



  attr_reader :label, :states, :state

  # @@label
  # @@states

  def initialize(configuration, integer)
    @value = integer
    @bit_array = BitArray.from_i(integer)
    # @label = 'Something Important'
    # @state = :ok
  end

  def inspect
    "<#{PROC} @label=#{label} @value=#{value} @state=#{state}>"
  end

  # @overide
  def to_s(width = DEFAULT_LABEL_WIDTH)
    return nil if [:ok, :off].include?(state)
    # LOGGER.info(PROC) { "#to_s(width = #{width})" }
    str_buffer = format("%-#{width}s", "#{label}")
    str_buffer = str_buffer.concat(LABEL_DELIMITER)
    str_buffer = str_buffer.concat("[#{pretty}]")
    str_buffer
  end

  # def state
  #   @states[value]
  # end

  # def foramtted_state(value)
  #   formatted_state = formatted(state)
  #   "[#{formatted_state}]"
  # end

  def state
    if @states.nil?
      LOGGER.warn(PROC) { "Map @states is no available!" }
      return "\"value\""
    elsif !@states.key?(value)
      LOGGER.warn(PROC) { "#{value} not found in @states!" }
      return "No states value!"
    else
      @states[value]
    end
  end

  # :off, :on, :ok, :fault
  def pretty
    case state
    when :off
      as_normal('OFF')
    when :on
      as_good('ON')
    when :ok
      as_good('OK')
    when :fault
      as_bad('FAULT')
    end
  end

  def as_bad(bit)
    as_colour(bit, 31)
  end

  def as_good(bit)
    as_colour(bit, 92)
  end

  def as_normal(bit)
    as_colour(bit, 3)
  end

  def as_colour(string, colour_id)
    str_buffer = "\33[#{colour_id}m"
    str_buffer = str_buffer.concat("#{string}")
    str_buffer = str_buffer.concat("\33[0m")
    str_buffer
  end

end
