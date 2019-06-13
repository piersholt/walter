# frozen_string_literal: true

puts "\tLoading wilhelm/core/helpers"

# require_relative 'delayable'
# require_relative 'stateful'

require_relative 'helpers/debug_tools'
# require_relative 'printable'

module Wilhelm
  module Core
    # All helpers available within single module
    module Helpers
      include Wilhelm::Helpers::ModuleTools
      extend Wilhelm::Helpers::ModuleTools
      include Wilhelm::Helpers::NameTools
      include Wilhelm::Core::Device::Groups
    end
  end
end
