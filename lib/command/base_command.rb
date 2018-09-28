require 'helpers'

# this is a comment about a thing?
class Command
  # Basic device class
  class BaseCommand
    include DataTools
    include Helpers
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

    def normal_fucking_decimal
      id.d
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
      str_buffer = sprintf("%-10s", sn)
      args_str_buffer = @arguments.map(&:h).join(' ')
      str_buffer.concat("\t#{args_str_buffer}") unless args_str_buffer.empty?
      str_buffer.concat("--") if args_str_buffer.empty?
      str_buffer
    end

    # ----------------------------- PROPERTIES ------------------------------ #

    def d
      @id.d
    end

    def b
      @id.b
    end

    def h
      @id.h
    end

    def sn(padded = PADDED_DEFAULT)
      padded ? sprintf("%-10s", short_name) : short_name
    end

    def set_parameters(params)
      set_properties(params)
    end

    private

    def set_properties(props)
      props.each do |name, value|
        instance_variable_set(inst_var(name), value)
      end
    end

    # ------------------------------ PRINTABLE ------------------------------ #

    # TODO: probaby a way of using yield?
    def bytes
      { ARGS: arguments }
    end

    public

    def try_set(parameter, parameter_value)
      LOGGER.info("#{self.class}") { "#try_set(#{parameter}, #{parameter_value})" }
      constant_value = evaluate_parameter_value(parameter, parameter_value)

      set_instance_parameter(parameter, constant_value)
    end

    private

    def evaluate_parameter_value(parameter, const_name)
      LOGGER.info("#{self.class}") { "#evaluate_parameter_value(#{parameter}, #{const_name})" }
      if const_name.instance_of?(Symbol)
        LOGGER.info("#{self.class}") { "#{const_name} is Symbol. Mapping symbol to #{self.class} constant." }
        const_name = parse_const_name(const_name)
        LOGGER.info("#{self.class}") { "Getting #{self.class}::#{const_name}" }
        constant_value = command_const_get(parameter, const_name)
      else
        LOGGER.info("#{self.class}") { "#{const_name} is type #{const_name.class}." }
        constant_value = const_name
      end
    end

    def command_const_get(parameter, const_name)
      LOGGER.info("#{self.class}") { "#command_const_get(:#{const_name})" }
      begin
        result = self.class.const_get(const_name)
        LOGGER.info("#{self.class}") { "#{self.class}::#{const_name}=#{result}" }
      rescue NameError => e
        LOGGER.error("#{self.class}") { "#{const_name} does not match a #{self.class} constant." }
        LOGGER.error("#{self.class}") { "Possible #{class_const(parameter)} constants are: #{parameter_constants(parameter)}" }
        result = 0x00
      end
      result
    end

    def set_instance_parameter(parameter, constant_value)
      LOGGER.info("#{self.class}") { "#set_instance_parameter(#{parameter}, #{constant_value})" }
      instance_variable_value = instance_variable_set(inst_var(parameter), constant_value)
      LOGGER.info("#{self.class}") { "#{inst_var(parameter)}=#{instance_variable_value}" }
      return instance_variable_value == constant_value ? true : false
    end

    # ^ ---------------- SETTING PARAMETERS VIA SYMBOL/CONSTANTS ---------------- ^ #
  end
end
