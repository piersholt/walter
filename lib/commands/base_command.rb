# this is a comment about a thing?
class Commands
  # Basic device class
  class BaseCommand
    # include Printable
    PADDED_DEFAULT = true

    attr_accessor :id, :short_name, :long_name, :arguments, :verbose

    alias :address :id
    # alias :sn :short_name
    alias :ln :long_name
    alias :args :arguments

    def initialize(id, props)
      LOGGER.debug("#{self.class}#initialize(#{id}, #{props})")
      @id = id
      parse_properties(props)
    end

    def d
      @id[:d]
    end

    def b
      DataTools.decimal_to_binary(d)
    end

    def sn(padded = PADDED_DEFAULT)
      padded ? sprintf("%-10s", short_name) : short_name
    end

    def h
      DataTools.decimal_to_hex(d)
    end

    def to_s
      return inspect if @verbose
      # str_buffer = "#{sn}"
      abvr = short_name == '???' ? h : short_name
      str_buffer = sprintf("%-10s", abvr)
      # args_str_buffer = @arguments.join(' ') { |a| a.to_h(true) }
      args_str_buffer = @arguments.map(&:h).join(' ')
      str_buffer.concat("\t#{args_str_buffer}") unless args_str_buffer.empty?
      str_buffer.concat("\t--") if args_str_buffer.empty?
      str_buffer
    end

    def inspect
      # str_buffer = "#{h} "
      str_buffer = sprintf("%-10s", h)
      args_str_buffer = @arguments.map(&:h).join(' ')
      str_buffer.concat("#{args_str_buffer}") unless args_str_buffer.empty?
      str_buffer.concat("--") if args_str_buffer.empty?
      str_buffer
    end

    # ------------------------------ PRINTABLE ------------------------------ #

    # TODO: probaby a way of using yield?
    def bytes
      { ARGS: arguments }
    end

    private

    def parse_properties(props)
      props.each do |name, value|
        instance_variable_set(inst_var(name), value)
      end
    end

    def inst_var(name)
      name_string = name.id2name
      '@'.concat(name_string).to_sym
    end
  end
end
