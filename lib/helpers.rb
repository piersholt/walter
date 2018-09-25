module ModuleTools
  # Retrieve a constant from a String i.e. "NameSpaceA::ClassX"
  def get_class(name)
    Kernel.const_get(name)
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
end

module Helpers
  include ModuleTools
  extend ModuleTools
  include NameTools
end
