# frozen_string_literal: true

puts 'Loading wilhelm/helpers'

require_relative 'helpers/data_tools'
require_relative 'helpers/module'
require_relative 'helpers/name'
require_relative 'helpers/stateful'
require_relative 'helpers/delayable'
require_relative 'helpers/console'
require_relative 'helpers/bitwise'
require_relative 'helpers/positional'
require_relative 'helpers/object'
require_relative 'helpers/inspect'
require_relative 'helpers/observation'
require_relative 'helpers/time'
require_relative 'helpers/checksum'
require_relative 'helpers/recovery'

module Wilhelm
  # Helpers
  module Helpers
    include Module
    extend Module
    include Name
  end
end

puts "\tDone!"
