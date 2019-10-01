# frozen_string_literal: true

module Wilhelm
  module API
    class Telephone
      # API::Telephone::SMS
      module SMS
        MOD_PROG = 'Telephone::SMS'

        def messages_index(*messages)
          bus.tel.messages_index(*messages)
        end

        def messages_show(message)
          bus.tel.messages_show(message)
        end
      end
    end
  end
end
