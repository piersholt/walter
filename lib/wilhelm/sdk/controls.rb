# frozen_string_literal: true

puts "\tLoading wilhelm/sdk/controls"

print "\tLoading wilhelm/sdk/controls/register => "
puts require_relative('controls/register') ? 'Success' : 'Error'
