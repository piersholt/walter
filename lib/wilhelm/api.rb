# frozen_string_literal: true

puts 'Loading wilhelm/api'

LogActually.is_all_around(:api)

LogActually.api.i

module Wilhelm
  module API
    LOGGER = LogActually.api
  end
end

require_relative 'api/constants'
require_relative 'api/display'
require_relative 'api/controls'
require_relative 'api/audio'
require_relative 'api/telephone'

puts "\tDone!"
