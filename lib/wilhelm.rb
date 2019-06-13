# frozen_string_literal: true

begin
  def add_load_path(dir)
    load_path = File.expand_path(File.dirname(__FILE__) + "/wilhelm/#{dir}")
    $LOAD_PATH.unshift(load_path) unless $LOAD_PATH.include?(load_path)
  rescue StandardError => e
    puts e
    e.backtrace.each { |line| puts line }
    exit
  end

  add_load_path('helpers')
  add_load_path('core')
  add_load_path('virtual')
  add_load_path('api')
  add_load_path('sdk')

  # Setup namespace prior to loading deprendencies to allow for any files that
  # reference Wilhelm via short names, i.e. class Wilhelm::MyKlass
  module Wilhelm; end

  require 'wilhelm/helpers'
  require 'wilhelm/core'
  require 'wilhelm/virtual'
  require 'wilhelm/api'
  require 'wilhelm/sdk'
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
