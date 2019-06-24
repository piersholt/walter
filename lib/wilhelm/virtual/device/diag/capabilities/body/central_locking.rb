# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module Body
            module CentralLocking
              HATCH_OPEN        = '00 0A 01'
              TRUNK_OPEN_REMOTE = '00 08 01'

              # HATCH_OPEN        = '00 07 01'
              TRUNK_OPEN        = '00 09 01'

              TRUNK_CONTACT     = '00 0A 01'
              HATCH_CONTACT     = '00 1D 01'

              # This is a state switch
              CENTRAL_LOCK      = '00 0B 01'

              # Lock 3	DIS Unknown 	General news 1
              # Lock Driver	DIS Unknown 	General news 1
              # Trunc Open	DIS Unknown 	General news 1

              LOCK_DRIVER = '47 01' # no
              LOCK_MINOR  = '4F 01' # no
              # TRUNK_OPEN  = '02 01'

              UNLOCK_ALL = '96 01' # no
              LOCK_ALL =  '97 01' # no
            end
          end
        end
      end
    end
  end
end
