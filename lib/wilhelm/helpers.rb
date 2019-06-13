# frozen_string_literal: true

puts 'Loading wilhelm/helpers'

require_relative 'helpers/data_tools'
require_relative 'helpers/module_tools'
require_relative 'helpers/name_tools'

module Wilhelm
  # Comment
  module Helpers
    include ModuleTools
    extend ModuleTools
    include NameTools
  end
end

puts "\tDone!"
