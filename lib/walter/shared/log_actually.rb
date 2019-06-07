# frozen_string_literal: true

require 'logger'
require 'singleton'

require_relative 'log_actually/constants'
require_relative 'log_actually/ascii_colour'
require_relative 'log_actually/formatter'
require_relative 'log_actually/log'
require_relative 'log_actually/forrest'
require_relative 'log_actually/error_output'

# Comment
class LogActually
  include Constants
  def self.is_all_around(id, stream = STDERR)
    log = Log.new(id, stream)
    Forrest.instance.add(id, log)
    send(id)
  end

  def self.welcome
    log = Log.new(:welcome, STDERR)
    Forrest.instance.add(:welcome, log)
    welcome_log = Forrest.instance.loggers[:welcome]
    welcome_log.info(MOI) { 'Beause log actually..., is all around. ❤️' }
    Forrest.instance.remove(:welcome)
    true
  end
end

LogActually.welcome
