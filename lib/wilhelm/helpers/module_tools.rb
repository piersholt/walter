# frozen_string_literal: false

module Wilhelm
  module Helpers
    # Comment
    module ModuleTools
      # Retrieve a constant from a String i.e. "NameSpaceA::ClassX"
      def get_class(name)
        Kernel.const_get(name)
      end

      # @deprecated in favour of #join_namespaces
      def prepend_namespace(command_namespace, klass)
        "#{command_namespace}::#{klass}"
      end

      def join_namespaces(*constants)
        constants.join('::')
      end
    end
  end
end
