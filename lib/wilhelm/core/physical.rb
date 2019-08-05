# frozen_string_literal: true

require_relative 'physical/buffer'

puts "\tLoading wilhelm/core/physical/model"

require_relative 'physical/model/byte'

require_relative 'physical/model/bytes/indexed'
require_relative 'physical/model/bytes'

require_relative 'physical/model/bit_array/indexed'
require_relative 'physical/model/bit_array'

puts "\tLoading wilhelm/core/physical"

require_relative 'physical/state'
require_relative 'physical/file'
require_relative 'physical/tty'
require_relative 'physical/stat'
