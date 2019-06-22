# frozen_string_literal: false

puts "\tLoading wilhelm/virtual/device/tel"

require_relative 'tel/api'
require_relative 'tel/capabilities'

require_relative 'tel/emulated/state/model'
require_relative 'tel/emulated/state/chainable'
require_relative 'tel/emulated/state'
require_relative 'tel/emulated/received'
require_relative 'tel/emulated/handlers'
require_relative 'tel/emulated'
