# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module MFL
        # API for command related to keys
        module API
          include Constants::Command::Aliases
          include Device::API::BaseAPI

          def mfl_func_button(from: :mfl, to:, **arguments)
            LOGGER.unknown('API::MFL') { "#{from}, #{to}, #{arguments}" }
            # try(from, to, MFL_FUNC, arguments)
          end

          def mfl_vol_button(from: :mfl, to: :rad, **arguments)
            LOGGER.unknown('API::MFL') { "#{from}, #{to}, #{arguments}" }
            # try(from, to, MFL_VOL, arguments)
          end
        end
      end
    end
  end
end
