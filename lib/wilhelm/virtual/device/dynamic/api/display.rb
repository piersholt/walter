# frozen_string_literal: false

module Wilhelm::Virtual::API
  # Comment
  module Display
    include BaseAPI
    include Wilhelm::Virtual::Constants::Command::Aliases

    # 0x21
    def mid(from: :tel, to: :gfx, **arguments)
      arguments[:m1] = 0x43 unless arguments[:m1]
      arguments[:m2] = 0x01 unless arguments[:m2]
      arguments[:m3] = 0x32 unless arguments[:m3]
      # format_chars!(arguments)
      try(from, to, TXT_MID, arguments)
    end

    # 0x23
    def displays(from: :tel, to: :gfx, **arguments)
      format_chars!(arguments)
      try(from, to, TXT_GFX, arguments)
    end

    # 0x24
    def hud(from: :rad, to: :glo_h, **arguments)
      format_chars!(arguments)
      try(from, to, TXT_HUD, arguments)
    end
  end
end
