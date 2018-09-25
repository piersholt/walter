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

    # ------------------------------ PARAMETERS ------------------------------ #

    # def parameters
    #   self.class.const_get(:PARAMETERS)
    # end

    # only list the constants that correspond to the parameter
    # don't use CommandMap. Methods performing on class's own data...
    # KLASS::PARAMETER { constant_a: byte_value, constant_b: byte_value,  }
    # def parameter_constants(parameter)
    #   self.class.const_get(class_const(parameter))
    # end

    # ------------------------------ PARAMETERS ------------------------------ #

    # @deprecated for #dictionary(param_name)
    # def dict(param, value)
    #   param_data = self.class.class_variable_get(:@@parameters)
    #   LOGGER.warn("#{self.class}") { 'No param data, thus no dictionary! '} unless param_data
    #   param_dictionary = param_data[param][:dictionary]
    #   LOGGER.warn("#{self.class}") { 'No dictionary!'} unless param_dictionary
    #   param_dictionary[value]
    # end

    # @deprecated for #nested_dictionary(param_name) which supports bit_arrays
    # def dictionary(param_name)
    #   param_data = self.class.class_variable_get(:@@parameters)
    #   LOGGER.warn("#{self.class}") { 'No param data, thus no dictionary! '} unless param_data
    #   param_dictionary = param_data[param_name][:dictionary]
    #   LOGGER.warn("#{self.class}") { 'No dictionary!'} unless param_dictionary
    #   value = public_send(param_name)
    #   param_dictionary[value]
    # end

    # @deprecated
    # def nested_dictionary(param_name)
    #   # param_data = self.class.class_variable_get(:@@parameters)
    #   # LOGGER.warn("#{self.class}") { 'No param data, thus no dictionary! '} unless param_data
    #   command_dictionary = self.class.const_get(:DICTIONARY)
    #   LOGGER.warn("#{self.class}") { 'No command dictionary!'} unless command_dictionary
    #   param_dictionary = command_dictionary[param_name]
    #   LOGGER.warn("#{self.class}") { "No #{param_name} dictionary!"} unless param_dictionary
    #   value = public_send(param_name)
    #   param_dictionary[value]
    # end

    # ------------------ SETTING PARAMETERS (FOR API) ------------------ #
    # Setting parameters via symbol/constants

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


    # @deprecated
    # @return [Instance Variable] :@variable_name
    # def inst_var(name)
    #   name_string = name.id2name
    #   '@'.concat(name_string).to_sym
    # end
    #
    # @deprecated
    # @return [Class Variable] :@@variable_name
    # def class_var(name)
    #   name_string = name.id2name
    #   '@@'.concat(name_string).to_sym
    # end
    #
    # @deprecated
    # @return [Class Constant] :CONSTANT_NAME
    # def class_const(name)
    #   name_string = name.upcase
    #   name_string.to_sym
    # end

    # @deprecated
    # @return [Class Constant] :CONSTANT_NAME
    # def parse_const_name(const_name)
    #   LOGGER.debug("#{self.class}") { "#parse_const_ref(#{const_name})" }
    #   LOGGER.debug("#{self.class}") { "Parsing #{const_name} to valid class constant name." }
    #   begin
    #     const_name_buffer = const_name.upcase
    #     const_name_buffer = const_name_buffer.to_sym
    #   rescue StandardError => e
    #     LOGGER.error("#{self.class}") { "When trying to change #{const_name} to constant." }
    #     LOGGER.error("#{self.class}") { e }
    #     e.backtrace.each { |l| LOGGER.error("#{self.class}") { l } }
    #   end
    #   LOGGER.debug("#{self.class}") { "Command constant name is: #{const_name_buffer}" }
    #   const_name_buffer
    # end
  end
end
