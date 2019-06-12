# frozen_string_literal: true

module Wilhelm::Virtual::Capabilities
  # Comment
  module Telephone
    include Constants
    include Helpers
    include Ready

    include LED
    include Directory
    include Info

    def logger
      LogActually.tel
    end

    def set_status(bit_array)
      status(status: bit_array)
    end
  end
end
