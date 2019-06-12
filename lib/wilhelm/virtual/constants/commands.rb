# frozen_string_literal: false

class Wilhelm::Virtual
  module Constants
    # Should commands that do not affect module state be relayed...?
    module Commands
      GFX_PING = :gfx_ping
      GFX_ANNOUNCE = :gfx_announce

      GFX_OBC_REQ = :gfx_obc_req

      DATA_SELECT = :data_select
    end
  end
end
