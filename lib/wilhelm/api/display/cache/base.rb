# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      class Cache
        # API::Display::Cache::Base
        class BaseCache
          include Attributes
          attr_reader :attributes
        end
      end
    end
  end
end
