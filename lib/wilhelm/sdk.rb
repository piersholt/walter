# frozen_string_literal: true

puts 'Loading walter/sdk'

# Walter SDK
LogActually.is_all_around(:notify)
LogActually.is_all_around(:alive)
LogActually.is_all_around(:ui)
LogActually.is_all_around(:audio_service)
LogActually.is_all_around(:manager_service)
LogActually.is_all_around(:node)
LogActually.is_all_around(:wolfgang)

LogActually.notify.i
LogActually.alive.i
LogActually.ui.i
LogActually.audio_service.i
LogActually.manager_service.d
LogActually.node.i
LogActually.wolfgang.i

require_relative 'sdk/controls'
require_relative 'sdk/ui'
require_relative 'sdk/notifications'
require_relative 'sdk/nodes'
require_relative 'sdk/context'

puts "\tDone!"
