# frozen_string_literal: true

puts "\tLoading wilhelm/core/errors"

require_relative 'errors/all'

module Wilhelm
  module Core
    # wilhelm-core Errors
    module Errors
      include Frame
      include Transmitter
      include Handler
    end

    include Errors
  end
end
