# frozen_string_literal: true

module Wilhelm
  module API
    class Telephone
      # API::Telephone::Directory
      module Directory
        MOD_PROG = 'Telephone::Directory'

        def directory_contact_list(*contacts)
          bus.tel.directory_contact_list(*contacts)
        end

        def directory_name(contact_name)
          bus.tel.directory_name(contact_name)
        end
      end
    end
  end
end
