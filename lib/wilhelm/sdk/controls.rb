# frozen_string_literal: true

puts "\tLoading wilhelm/sdk/controls"

# puts File.dirname(__FILE__)
# puts File.expand_path('register')
print "\tLoading wilhelm/sdk/controls/register"
# binding.pry
result = require_relative 'controls/register'
print ' => '
puts result ? 'Success' : 'Error'
