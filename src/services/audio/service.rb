# frozen_string_literal: true

module Wolfgang
  # Comment
  class Audio
    include Observable

    include Logging
    include Properties
    include State
    include Notifications
    include Controls
    include Actions

    include Messaging::API

    attr_reader :state

    def initialize
      @state = Disabled.new
    end
  end
end
