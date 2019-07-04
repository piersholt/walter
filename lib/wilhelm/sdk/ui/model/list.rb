# frozen_string_literal: true

module Wilhelm
  module SDK
    module UIKit
      module Model
        # Model::List
        class List
          DEFAULT_PAGE_SIZE = 8
          DEFAULT_INDEX = 0
          DEFAULT_OPTIONS = { page_size: DEFAULT_PAGE_SIZE, index: DEFAULT_INDEX }
          PROG = 'Model::List'

          attr_accessor :page_size
          attr_reader :index

          def initialize(items_array, opts = DEFAULT_OPTIONS)
            @list_items = items_array
            @page_size = opts[:page_size]
            @index = opts[:index]
          end

          def page
            # LOGGER.unknown(PROG) { '#page' }
            # LOGGER.unknown(PROG) { "index => #{index}" }
            # LOGGER.unknown(PROG) { "page_size => #{page_size}" }
            # LOGGER.unknown(PROG) { "@list_items => #{@list_items}" }
            result = @list_items[index, page_size]
            LOGGER.unknown(PROG) { "page => #{result}" }
            result
          end

          def shift(i)
            @list_items.rotate!(i)
            # @index += i
            # index
            i
          end

          def forward
            # LOGGER.unknown(self.class.name) { "#forward" }
            shift(page_size)
          end

          def backward
            # LOGGER.unknown(self.class.name) { "#backward" }
            shift(-page_size)
          end
        end
      end
    end
  end
end
