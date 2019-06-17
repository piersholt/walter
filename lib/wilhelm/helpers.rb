# frozen_string_literal: true

puts 'Loading wilhelm/helpers'

require_relative 'helpers/data_tools'
require_relative 'helpers/module'
require_relative 'helpers/name'
require_relative 'helpers/stateful'
require_relative 'helpers/delayable'
require_relative 'helpers/console'

module Wilhelm
  # Comment
  module Helpers
    include Module
    extend Module
    include Name
  end
end

puts "\tDone!"
