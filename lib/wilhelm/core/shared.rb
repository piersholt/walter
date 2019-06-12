# frozen_string_literal: true

puts "\tLoading wilhelm/core/shared"

require_relative 'shared/types/bit_array'
require_relative 'shared/types/indexed_bit_array'

require_relative 'shared/base/event'
require_relative 'shared/base/base_handler'
require_relative 'shared/base/base_listener'

require_relative 'shared/session/session_handler'
require_relative 'shared/session/session_listener'

require_relative 'shared/display/display_handler'
require_relative 'shared/display/display_listener'

require_relative 'shared/data_logging/data_logging_handler'
require_relative 'shared/data_logging/data_logging_listener'

require_relative 'shared/maps/map'

require_relative 'shared/global_listener'

# Comment
module Shared
  def session_listener
    @session_listener ||= SessionListener.new
  end

  def data_logging_listener
    @data_logging_listener ||= DataLoggingListener.new
  end

  def display_listener
    @display_listener ||= DisplayListener.new
  end

  def global_listener
    @global_listener ||= GlobalListener.new({})
  end
end
