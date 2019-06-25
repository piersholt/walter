# frozen_string_literal: true

puts "\tLoading wilhelm/core/data_link"

module Wilhelm
  module Core
    module DataLink
      include Constants
    end
  end
end

require_relative 'data_link/constants'
require_relative 'data_link/model'
require_relative 'data_link/synchronisation'
require_relative 'data_link/receiver'
require_relative 'data_link/transmitter'
require_relative 'data_link/multiplexer'
require_relative 'data_link/demultiplexer'
