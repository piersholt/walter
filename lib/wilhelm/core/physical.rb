# frozen_string_literal: true

require_relative 'physical/buffer'

puts "\tLoading wilhelm/core/physical/model"

require_relative 'physical/model/byte'
require_relative 'physical/model/byte_basic'
require_relative 'physical/model/bytes'

puts "\tLoading wilhelm/core/physical"

require_relative 'physical/state'
require_relative 'physical/file'
require_relative 'physical/tty'
require_relative 'physical/stat'
