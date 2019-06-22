# frozen_string_literal: false

puts "\tLoading wilhelm/virtual/device/radio"

require_relative 'radio/api'
require_relative 'radio/capabilities'

require_relative 'radio/augmented/state/constants'
require_relative 'radio/augmented/state/model'
require_relative 'radio/augmented/state/chainable'
require_relative 'radio/augmented/state/received'
require_relative 'radio/augmented/state'
require_relative 'radio/augmented/actions'
require_relative 'radio/augmented/notifications'
require_relative 'radio/augmented'

require_relative 'radio/emulated'
