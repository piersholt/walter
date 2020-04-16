# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT2
        module API
          # GT2::API::Menu
          module Menu
            include Wilhelm::Helpers::Parse
            include Constants

            def menu(from: :gt2, to: :nav, arguments:)
              try(from, to, 0xAA, bytes(*arguments))
            end
          end
        end
      end
    end
  end
end
