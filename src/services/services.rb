# frozen_string_literal: true

puts 'Loading walter-plugin'

# Audio
puts "\tLoading walter-plugin/audio"
require_relative 'audio/audio'

# Manager
puts "\tLoading walter-plugin/manager"
require_relative 'manager/manager'
