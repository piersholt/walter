# frozen_string_literal: true

puts 'Loading wilhelm/tools'

LogActually.is_all_around(:tools)

LogActually.tools.i

module Wilhelm
  module Tools
    LOGGER = LogActually.tools
  end
end

# Sniffer
print "\tLoading wilhelm/tools/sniffer => "
puts require_relative('tools/sniffer') ? 'Success' : 'Failed'

puts "\tDone!"
