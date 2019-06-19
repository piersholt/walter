# frozen_string_literal: true

puts 'Loading wilhelm/services'

LogActually.is_all_around(:services)

LogActually.services.i

# Audio
print "\tLoading wilhelm/services/audio => "
puts require_relative('services/audio') ? 'Success' : Error

# Manager
print "\tLoading wilhelm/services/manager => "
puts require_relative('services/manager') ? 'Success' : Error

# UI
puts "\tLoading wilhelm/services/ui"
require_relative 'services/ui'

puts "\tDone!"
