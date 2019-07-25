# frozen_string_literal: true

puts 'Loading wilhelm/services'

LogActually.is_all_around(:services)
LogActually.is_all_around(:manager)
LogActually.is_all_around(:audio)

LogActually.services.i
LogActually.audio.i

module Wilhelm
  module Services
    LOGGER = LogActually.services
  end
end

require_relative 'services/collection'

# Audio
print "\tLoading wilhelm/services/audio => "
puts require_relative('services/audio') ? 'Success' : Error

# Manager
print "\tLoading wilhelm/services/manager => "
puts require_relative('services/manager') ? 'Success' : Error

puts "\tDone!"
