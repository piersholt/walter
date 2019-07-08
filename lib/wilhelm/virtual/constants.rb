# frozen_string_literal: false

puts "\tLoading wilhelm/virtual/constants"

require_relative 'constants/command'
require_relative 'constants/device'

module Wilhelm
  module Virtual
    TYPE_BASE      = :base
    TYPE_AUGMENTED = :augmented
    TYPE_EMULATED  = :emulated
    TYPE_BROADCAST = :broadcast
    TYPE_DYNAMIC = [TYPE_EMULATED, TYPE_AUGMENTED].freeze
  end
end
