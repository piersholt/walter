# frozen_string_literal: true

module Wilhelm::Virtual::API
  # API for command related to keys
  module MultiFunctionWheel
    include Command::Aliases
    include BaseAPI

    def mfl_func_button(from: :mfl, to:, **arguments)
      LogActually.default.unknown('API::MFL') { "#{from}, #{to}, #{arguments}" }
      # try(from, to, MFL_FUNC, arguments)
    end

    def mfl_vol_button(from: :mfl, to: :rad, **arguments)
      LogActually.default.unknown('API::MFL') { "#{from}, #{to}, #{arguments}" }
      # try(from, to, MFL_VOL, arguments)
    end
  end
end
