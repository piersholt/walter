# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module CDChanger
            # CD Changer SELECT
            module Select
              include API

              def scan; end

              def random; end
            end
          end
        end
      end
    end
  end
end
