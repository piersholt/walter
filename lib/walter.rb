# frozen_string_literal: true

puts 'Loading walter'

puts "\tLoading walter/services"
require_relative 'walter/services'

puts "\tLoading walter/ui"
require_relative 'walter/ui'

puts "\tLoading walter/application"
require_relative 'walter/application'

puts "\tDone!"
