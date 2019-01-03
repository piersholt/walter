# frozen_string_literal: true

# Top level namespace
module Wolfgang
  # Default Wolfgang logger
  module Logger
    include LogActually::ErrorOutput
    def logger
      LogActually.wolfgang
    end
  end
end
