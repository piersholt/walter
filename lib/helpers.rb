require 'helpers/manageable_threads'
require 'helpers/delayable'

module ModuleTools
  # Retrieve a constant from a String i.e. "NameSpaceA::ClassX"
  def get_class(name)
    Kernel.const_get(name)
  end

  def prepend_namespace(command_namespace, klass)
    "#{command_namespace}::#{klass}"
  end
end

module ClusterTools
  HUD_SIZE = 20

  def centered(chars_string, opts = { upcase: true })
    upcase = opts[:upcase]

    chars_string = chars_string.center(HUD_SIZE)
    chars_string = chars_string.upcase if upcase
    chars_string
  end
end

module NameTools
  # Convert a symbol :name to instance variable name
  # @return [Instance Variable Name] :@variable_name
  def inst_var(name)
    name_string = name.id2name
    '@'.concat(name_string).to_sym
  end

  # Convert a symbol :name to class variable name
  # @return [Class Variable Name] :@@variable_name
  def class_var(name)
    name_string = name.id2name
    '@@'.concat(name_string).to_sym
  end

  # # Convert a symbol :name to class constant name
  # @return [Class Constant Name] :CONSTANT_NAME
  def class_const(name)
    name_string = name.upcase
    name_string.to_sym
  end

  # @deprecated
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

module Helpers
  include ModuleTools
  extend ModuleTools
  include NameTools
end
