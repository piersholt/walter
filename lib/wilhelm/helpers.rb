# frozen_string_literal: true

puts 'Loading wilhelm/helpers'

require_relative 'helpers/data_tools'
require_relative 'helpers/module'
require_relative 'helpers/name'
require_relative 'helpers/stateful'
require_relative 'helpers/delayable'

puts 'Loading wilhelm/helpers/debug'

require_relative 'helpers/debug/delayable'
require_relative 'helpers/debug/session'
require_relative 'helpers/debug/threads'
require_relative 'helpers/debug/yabber'
require_relative 'helpers/debug'

module Wilhelm
  # Comment
  module Helpers
    include Module
    extend Module
    include Name
  end
end

puts "\tDone!"
