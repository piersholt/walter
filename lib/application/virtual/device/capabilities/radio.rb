# frozen_string_literal: true

module Capabilities
  # Comment
  module Radio
    include Helpers
    include UserInterface
    include CDChangerControl
    include CDChangerDisplay
    include NavigationDisplay
  end
end
