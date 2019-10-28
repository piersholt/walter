# frozen_string_literal: false

puts "\tLoading wilhelm/virtual/device/gt"

require_relative 'gt/api'
require_relative 'gt/capabilities'

require_relative 'gt/augmented/state/constants'
require_relative 'gt/augmented/state/model'
require_relative 'gt/augmented/state/chainable'
require_relative 'gt/augmented/state/sent'
require_relative 'gt/augmented/state/received'
require_relative 'gt/augmented/state'
require_relative 'gt/augmented'

require_relative 'gt/emulated'
