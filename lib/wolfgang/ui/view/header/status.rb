# frozen_string_literal: true

module Wolfgang
  class UserInterface
    module View
      module Header
        # Comment
        class Status < DefaultHeader
          def initialize(*args)
            LogActually.wolfgang.debug(moi) { "#initialize(#{args})" }
            super(
              ['A',
               'B',
               'C',
               'D',
               'E',
               'F 0123456789abcedef',
               'G 0123456789abcedef'],
               'Wilhelm')
          end

          def moi
            'Header Status'
          end
        end
      end
    end
  end
end
