# frozen_string_literal: true

puts 'Loading wilhelm/api'

# Walter-API
LogActually.is_all_around(:display)
LogActually.is_all_around(:controls)
LogActually.is_all_around(:audio)
LogActually.is_all_around(:tel)

LogActually.display.w
LogActually.controls.i
LogActually.audio.i
LogActually.tel.i

require_relative 'api/display'
require_relative 'api/controls'
require_relative 'api/audio'
require_relative 'api/telephone'

puts "\tDone!"
