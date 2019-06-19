# frozen_string_literal: true

puts "\tLoading wilhelm/core/shared"

require_relative 'shared/types/bit_array'
require_relative 'shared/types/indexed_bit_array'

require_relative 'shared/base/base_handler'
require_relative 'shared/base/base_listener'

require_relative 'shared/session/session_handler'
require_relative 'shared/session/session_listener'

# Comment
module Shared
  def session_listener
    @session_listener ||= Wilhelm::Core::SessionListener.new
  end
end
