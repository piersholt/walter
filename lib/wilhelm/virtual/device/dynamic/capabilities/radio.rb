# frozen_string_literal: true

module Wilhelm
  module Virtual
    module Capabilities
      # Comment
      module Radio
        include Helpers
        include Ready
        include UserInterface
        include CDChangerControl
        include CDChangerDisplay
        include RDSDisplay
        include LED
      end
    end
  end
end
