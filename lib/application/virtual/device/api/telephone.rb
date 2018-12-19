# frozen_string_literal: true

module API
  # API for telephone related commands
  module Telephone
    include BaseAPI

    def led(from: :tel, to: :anzv, **arguments)
      try(from, to, 0x2b, arguments)
    end

    def status(from: :tel, to: :anzv, **arguments)
      try(from, to, 0x2c, arguments)
    end
  end
end
