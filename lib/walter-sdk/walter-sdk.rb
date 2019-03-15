# frozen_string_literal: true

puts 'Loading walter-sdk'

# Walter SDK
LogActually.is_all_around(:notify)
LogActually.notify.i
LogActually.is_all_around(:alive)
LogActually.alive.i
LogActually.is_all_around(:ui)
LogActually.ui.d
LogActually.is_all_around(:audio_service)
LogActually.audio_service.d
LogActually.is_all_around(:manager_service)
LogActually.manager_service.d
LogActually.is_all_around(:wolfgang)
LogActually.wolfgang.d

require_relative 'controls/controls'
require_relative 'ui/ui'
require_relative 'notifications/notifications'
require_relative 'context/context'

puts "\tDone!"
