# frozen_string_literal: true

puts "\tLoading wilhelm/virtual/constants"

require_relative 'constants/states'
require_relative 'constants/commands'
require_relative 'constants/buttons'

class Wilhelm::Virtual
  # TODO: rename to constants
  module Events
    include Constants::States
    include Constants::Commands
    include Constants::Buttons
  end
end
