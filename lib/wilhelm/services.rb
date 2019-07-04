# frozen_string_literal: true

puts 'Loading wilhelm/services'

LogActually.is_all_around(:services)

LogActually.services.i

module Wilhelm
  module Services
    LOGGER = LogActually.services
  end
end

# Audio
print "\tLoading wilhelm/services/audio => "
puts require_relative('services/audio') ? 'Success' : Error

# Manager
print "\tLoading wilhelm/services/manager => "
puts require_relative('services/manager') ? 'Success' : Error

puts "\tDone!"
