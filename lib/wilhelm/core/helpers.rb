# frozen_string_literal: true

puts "\tLoading wilhelm/core/helpers"

# require_relative 'delayable'
# require_relative 'stateful'

require_relative 'helpers/data_tools'
require_relative 'helpers/debug_tools'
require_relative 'helpers/cluster_tools'
require_relative 'helpers/module_tools'
require_relative 'helpers/name_tools'
# require_relative 'printable'

module Wilhelm::Core::Helpers
  include Wilhelm::Core::ModuleTools
  extend Wilhelm::Core::ModuleTools
  include Wilhelm::Core::NameTools
  include Wilhelm::Core::Device::Groups
end
