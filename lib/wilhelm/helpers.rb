# frozen_string_literal: true

puts 'Loading wilhelm/helpers'

require_relative 'helpers/data_tools'
require_relative 'helpers/module'
require_relative 'helpers/name'
require_relative 'helpers/stateful'
require_relative 'helpers/rate_limiter'
require_relative 'helpers/console'
require_relative 'helpers/bitwise'
require_relative 'helpers/positional'
require_relative 'helpers/object'
require_relative 'helpers/inspect'
require_relative 'helpers/observation'
require_relative 'helpers/time'
require_relative 'helpers/checksum'
require_relative 'helpers/recovery'
require_relative 'helpers/signed_magnitude'

module Wilhelm
  # Helpers
  module Helpers
    include Module
    extend Module
    include Name

    # @param String string "C8 04 BF 02 38 49"
    # Valid hex representations: C8, 0xC8, C8H
    # @return String [0xC8, 0x04, 0xBF, 0x02, 0x38, 0x49]
    def hex_string_to_string(string)
      string
        &.split
        &.map { |c| c.to_i(16) }
        &.map(&:chr)
        &.join
    end

    alias s2s hex_string_to_string
  end
end

puts "\tDone!"
