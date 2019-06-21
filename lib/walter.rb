# frozen_string_literal: true

puts 'Loading walter'

LogActually.is_all_around(:walter)
LogActually.walter.i

module Walter
  LOGGER = LogActually.walter
end

puts "\tLoading walter/application"
require_relative 'walter/application'

puts "\tDone!"
