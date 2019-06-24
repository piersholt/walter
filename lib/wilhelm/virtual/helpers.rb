# frozen_string_literal: true

puts "\tLoading wilhelm/virtual/helpers"

require_relative 'helpers/console'

module Wilhelm
  module Virtual
    # All helpers available within single module
    module Helpers
      include Wilhelm::Helpers::Module
      extend Wilhelm::Helpers::Module
      include Wilhelm::Helpers::Name
      # Device and Command constants now under Virtual.
      # I'm unsure if the absense of constants in Core
      # will cause any issues. Stand by....
      # include Wilhelm::Core::Device::Groups
    end
  end
end
