# frozen_string_literal: true

module Wilhelm
  module Core
    # wilhelm-core Errors
    module Errors
      class ChecksumError < StandardError; end
      class HeaderValidationError < StandardError; end
      class HeaderImplausibleError < StandardError; end
      class TailValidationError < StandardError; end
      class TransmissionError < StandardError; end
      class BaseHandlerError < StandardError; end
    end
    include Errors
  end
end
