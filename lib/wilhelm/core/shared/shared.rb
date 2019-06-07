# frozen_string_literal: true

puts "\tLoading wilhelm/core/shared"

root = 'shared'

types_root = "#{root}/types"
require "#{types_root}/bit_array"
require "#{types_root}/indexed_bit_array"

base_root = "#{root}/base"
require "#{base_root}/event"
require "#{base_root}/base_handler"
require "#{base_root}/base_listener"

session_root = "#{root}/session"
require "#{session_root}/session_handler"
require "#{session_root}/session_listener"

display_root = "#{root}/display"
require "#{display_root}/display_handler"
require "#{display_root}/display_listener"

data_logging_root = "#{root}/data_logging"
require "#{data_logging_root}/data_logging_handler"
require "#{data_logging_root}/data_logging_listener"

maps_root = "#{root}/maps"
require "#{maps_root}/map"

require "#{root}/global_listener"

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
