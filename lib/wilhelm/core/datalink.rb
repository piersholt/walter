# frozen_string_literal: true

puts "\tLoading wilhelm/core/data_link"

puts "\tLoading wilhelm/core/data_link/frame"
require_relative 'data_link/frame/frame_header'
require_relative 'data_link/frame/frame_tail'
require_relative 'data_link/frame/frame'
require_relative 'data_link/frame/frame_synchronisation'
require_relative 'data_link/frame/indexed_arguments'
require_relative 'data_link/frame/arguments_builder'
require_relative 'data_link/frame/frame_builder'

puts "\tLoading wilhelm/core/data_link/fbzv"
require_relative 'data_link/fbzv/frame_synchronisation'

puts "\tLoading wilhelm/core/data_link/transceiver"
require_relative 'data_link/transceiver/receiver'
require_relative 'data_link/transceiver/transmitter'

puts "\tLoading wilhelm/core/data_link/model"
require_relative 'data_link/model/packet'

puts "\tLoading wilhelm/core/data_link/multiplexing"
require_relative 'data_link/multiplexing/multiplexer'
require_relative 'data_link/multiplexing/demultiplexer'
