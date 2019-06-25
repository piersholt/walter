# frozen_string_literal: true

module Wilhelm
  module Core
    # wilhelm-core Errors
    module Errors
      class BaseHandlerError < StandardError; end
      class ChecksumError < StandardError; end
      class HeaderImplausibleError < StandardError; end
      class HeaderValidationError < StandardError; end
      class TailValidationError < StandardError; end
      class TransmissionError < StandardError; end
    end
  end
end
