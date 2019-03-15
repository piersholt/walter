# frozen_string_literal: true

puts "\tLoading walter-sdk/controls"

# puts File.dirname(__FILE__)
# puts File.expand_path('register')
print "\tLoading walter-sdk/controls/register"
# binding.pry
result = require_relative './register.rb'
print ' => '
puts result ? 'Success' : 'Error'
