# frozen_string_literal: true

puts 'Loading wilhelm/services'

LogActually.is_all_around(:services)
LogActually.is_all_around(:manager)
LogActually.is_all_around(:audio)
LogActually.is_all_around(:telephone)

LogActually.services.i
LogActually.manager.i
LogActually.audio.i
LogActually.telephone.i

module Wilhelm
  module Services
    LOGGER = LogActually.services
  end
end

require_relative 'services/collection'
require_relative 'services/timer'

# Audio
print "\tLoading wilhelm/services/audio => "
puts require_relative('services/audio') ? 'Success' : 'Failed'

# Manager
print "\tLoading wilhelm/services/manager => "
puts require_relative('services/manager') ? 'Success' : 'Failed'

# Manager
print "\tLoading wilhelm/services/telephone => "
puts require_relative('services/telephone') ? 'Success' : 'Failed'

puts "\tDone!"
