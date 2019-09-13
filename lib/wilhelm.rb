# frozen_string_literal: true

begin
  # Setup namespace prior to loading deprendencies to allow for any files that
  # reference Wilhelm via short names, i.e. class Wilhelm::MyKlass
  module Wilhelm; end

  require_relative 'wilhelm/helpers'
  require_relative 'wilhelm/core'
  require_relative 'wilhelm/virtual'
  require_relative 'wilhelm/api'
  require_relative 'wilhelm/sdk'
  require_relative 'wilhelm/services'
  require_relative 'wilhelm/tools'
rescue LoadError => e
  puts "#{e.class}: #{e}"
  e.backtrace.each { |line| puts "\t#{line}" }
  puts 'Load Path:'
  $LOAD_PATH.each { |line| puts "\t#{line}" }
  exit
rescue StandardError => e
  puts "#{e.class}: #{e}"
  e.backtrace.each { |line| puts line }
  exit
end
