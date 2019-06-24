# frozen_string_literal: true

puts "\tLoading wilhelm/core/data_link"

puts "\tLoading wilhelm/core/data_link/frame"
require_relative 'data_link/frame/header'
require_relative 'data_link/frame/tail'
require_relative 'data_link/frame/frame'
require_relative 'data_link/frame/synchronisation'
require_relative 'data_link/frame/builder'

# puts "\tLoading wilhelm/core/data_link/fbzv"
# require_relative 'data_link/fbzv/frame_synchronisation'

# puts "\tLoading wilhelm/core/data_link/peripheral"
# require_relative 'data_link/peripheral/synchronisation'
# require_relative 'data_link/peripheral/frames'
# require_relative 'data_link/peripheral/frame_adapter'
# require_relative 'data_link/peripheral/pbus_receiver'

puts "\tLoading wilhelm/core/data_link/transceiver"
require_relative 'data_link/transceiver/receiver'
require_relative 'data_link/transceiver/transmitter'

puts "\tLoading wilhelm/core/data_link/model"
require_relative 'data_link/model/packet'

puts "\tLoading wilhelm/core/data_link/multiplexing"
require_relative 'data_link/multiplexing/multiplexer'
require_relative 'data_link/multiplexing/demultiplexer'
