require 'application/virtual/api/base_api'

module API
  module Display
    include BaseAPI

    DISPLAYS = {
      id:   0x23,
      from: :rad,
      to:   :glo_h
    }.freeze

    MID = {
      id:   0x21,
      from: :tel,
      to:   :gfx
    }.freeze

    # @param command_arguments[:chars] Array<Integer>
    def mid(command_arguments,
            from_id = MID[:from],
            to_id = MID[:to])
      command_id = MID[:id]

      command_arguments[:m1] = 0x43 unless command_arguments[:m1]
      command_arguments[:m2] = 0x01 unless command_arguments[:m2]
      command_arguments[:m3] = 0x32 unless command_arguments[:m3]

      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end

    # @param command_arguments[:chars] Array<Integer>
    def raw(command_arguments,
            from_id = DISPLAYS[:from],
            to_id = DISPLAYS[:to])
      command_id = DISPLAYS[:id]
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end

    def displays(command_arguments,
                 from_id = DISPLAYS[:from],
                 to_id = DISPLAYS[:to])
      command_id = DISPLAYS[:id]
      format_chars!(command_arguments)
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end

    HUD_TEXT = {
      id:   0x24,
      from: :ike,
      to:   :glo_h
    }.freeze

    def hud(command_arguments, from_id = HUD_TEXT[:from], to_id = HUD_TEXT[:to])
      command_id = HUD_TEXT[:id]
      format_chars!(command_arguments)
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end
  end
end
