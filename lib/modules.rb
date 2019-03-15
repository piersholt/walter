# frozen_string_literal: true

begin
  core_path = File.expand_path(File.dirname(__FILE__) + '/walter-core')
  virtual_path = File.expand_path(File.dirname(__FILE__) + '/walter-virtual')
  api_path = File.expand_path(File.dirname(__FILE__) + '/walter-api')
  sdk_path = File.expand_path(File.dirname(__FILE__) + '/walter-sdk')

  $LOAD_PATH.unshift(core_path) unless $LOAD_PATH.include?(core_path)
  $LOAD_PATH.unshift(virtual_path) unless $LOAD_PATH.include?(virtual_path)
  $LOAD_PATH.unshift(api_path) unless $LOAD_PATH.include?(api_path)
  $LOAD_PATH.unshift(sdk_path) unless $LOAD_PATH.include?(sdk_path)

  require 'walter-core'
  require 'walter-virtual'
  require 'walter-api'
  require 'walter-sdk'
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
