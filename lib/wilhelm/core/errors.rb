# frozen_string_literal: true

module Wilhelm
  module Core
    # wilhelm-core Errors
    module Errors
      # Comment
      module Frame
        # Comment
        class ChecksumError < StandardError; end
        # Comment
        class HeaderValidationError < StandardError; end

        # Comment
        class HeaderImplausibleError < StandardError; end

        # Comment
        class TailValidationError < StandardError; end
      end

      module Transmitter
        # Comment
        class TransmissionError < StandardError; end
      end

      module Handler
        # Comment
        class BaseHandlerError < StandardError; end
      end
    end

    include Errors
  end
end
