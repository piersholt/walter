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
      LOGGER.debug("BaseCommand") { "#initialize(#{id}, #{props})" }
      @id = id
      set_properties(props)
    end

    # -------------------------------- OBJECT ------------------------------- #

    def to_s
      return inspect if @verbose
      # str_buffer = "#{sn}"
      abvr = short_name == '???' ? h : short_name
      str_buffer = sprintf("%-10s", abvr)
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

    # ------------------------------ COMMAND ID ----------------------------- #

    def d
      @id.d
    end

    def b
      @id.b
    end

    def h
      @id.h
    end

    # ----------------------------- PROPERTIES ------------------------------ #

    def sn(padded = PADDED_DEFAULT)
      padded ? sprintf("%-10s", short_name) : short_name
    end

    # ------------------------------ PRINTABLE ------------------------------ #

    # TODO: probaby a way of using yield?
    def bytes
      { ARGS: arguments }
    end

    private

    def set_properties(props)
      props.each do |name, value|
        instance_variable_set(inst_var(name), value)
      end
    end

    def dict(param, value)
      param_data = self.class.class_variable_get(:@@parameters)
      LOGGER.warn("#{self.class}") { 'No param data, thus no dictionary! '} unless param_data
      param_dictionary = param_data[param][:dictionary]
      LOGGER.warn("#{self.class}") { 'No dictionary!'} unless param_dictionary
      param_dictionary[value]
    end

    def inst_var(name)
      name_string = name.id2name
      '@'.concat(name_string).to_sym
    end

    def class_var(name)
      name_string = name.id2name
      '@@'.concat(name_string).to_sym
    end
  end
end
