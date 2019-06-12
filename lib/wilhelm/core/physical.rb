# frozen_string_literal: true

puts "\tLoading wilhelm/core/physical"

require_relative 'physical/model/byte'
require_relative 'physical/model/byte_basic'
require_relative 'physical/model/bytes'

puts "\tLoading wilhelm/core/physical/interface"

require_relative 'physical/interface/UART'
require_relative 'physical/interface/file'
require_relative 'physical/interface'

puts "\tLoading wilhelm/core/physical/buffer"

require_relative 'physical/buffer/byte_buffer'
require_relative 'physical/buffer/output_buffer'
