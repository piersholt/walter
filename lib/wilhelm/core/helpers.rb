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

module Helpers
  include ModuleTools
  extend ModuleTools
  include NameTools
  include Device::Groups
end
