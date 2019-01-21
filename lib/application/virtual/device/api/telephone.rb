# frozen_string_literal: true

module API
  # API for telephone related commands
  module Telephone
    include BaseAPI
    include CommandAliases

    def led(from: :tel, to: :anzv, **arguments)
      try(from, to, 0x2b, arguments)
    end

    def status(from: :tel, to: :anzv, **arguments)
      try(from, to, 0x2c, arguments)
    end

    # 0x21
    def mid(from: :tel, to: :gfx, **arguments)
      arguments[:m1] = 0x43 unless arguments[:m1]
      arguments[:m2] = 0x01 unless arguments[:m2]
      arguments[:m3] = 0x32 unless arguments[:m3]
      # format_chars!(arguments)
      try(from, to, TXT_MID, arguments)
    end

    # 0x23
    def primary(from: :tel, to: :gfx, **arguments)
      format_chars!(arguments)
      try(from, to, TXT_GFX, arguments)
    end

    # 0x24
    def hud(from: :rad, to: :glo_h, **arguments)
      # format_chars!(arguments)
      try(from, to, TXT_HUD, arguments)
    end
  end
end
