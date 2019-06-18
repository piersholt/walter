# frozen_string_literal: true

puts 'Loading wilhelm/services'

# Audio
puts "\tLoading wilhelm/services/audio"
require_relative 'services/audio'

# Manager
puts "\tLoading wilhelm/services/manager"
require_relative 'services/manager'

# UI
puts "\tLoading wilhelm/services/ui"
require_relative 'services/ui'

puts "\tDone!"
