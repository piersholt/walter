module Wilhelm::Core::ModuleTools
  # Retrieve a constant from a String i.e. "NameSpaceA::ClassX"
  def get_class(name)
    Kernel.const_get(name)
  end

  def prepend_namespace(command_namespace, klass)
    "#{command_namespace}::#{klass}"
  end
end
