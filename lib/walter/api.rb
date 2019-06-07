# frozen_string_literal: true

puts 'Loading walter/api'

# Walter-API
LogActually.is_all_around(:display)
LogActually.display.w
LogActually.is_all_around(:controls)
LogActually.controls.i
LogActually.is_all_around(:audio)
LogActually.audio.i
LogActually.is_all_around(:tel)
LogActually.tel.i

puts "\tLoading walter/api/display"

display_root = 'display'
require "#{display_root}/states/defaults"
require "#{display_root}/states/unknown"
require "#{display_root}/states/disabled"
require "#{display_root}/states/enabled"
require "#{display_root}/states/busy"
require "#{display_root}/states/available"
require "#{display_root}/states/captured"
require "#{display_root}/states/overwritten"

require "#{display_root}/handlers/cache_handler"
require "#{display_root}/handlers/input_handler"
require "#{display_root}/listener"

require "#{display_root}/cache/value"
require "#{display_root}/cache/attributes"
require "#{display_root}/cache/layout_cache"
require "#{display_root}/cache/cache"

require "#{display_root}/display"

puts "\tLoading walter/api/controls"

# controls_root = 'controls'
# require "#{controls_root}/states/defaults"
# require "#{controls_root}/states/unknown"
# require "#{controls_root}/states/disabled"
# require "#{controls_root}/states/enabled"
# require "#{controls_root}/states/busy"
# require "#{controls_root}/states/available"
# require "#{controls_root}/states/captured"
# require "#{controls_root}/states/overwritten"

# require "#{controls_root}/handlers/cache_handler"
# require "#{controls_root}/handlers/input_handler"
require_relative 'api/controls/listener'
require_relative 'api/controls/control/base'
require_relative 'api/controls/control/stateless'
require_relative 'api/controls/control/stateful'
require_relative 'api/controls/control/two_stage'

require_relative 'api/controls/control'
require_relative 'api/controls/controls'

puts "\tLoading walter/api/audio"

audio_root = 'audio'
# require "#{audio_root}/states/defaults"
# require "#{audio_root}/states/unknown"
# require "#{audio_root}/states/disabled"
# require "#{audio_root}/states/enabled"
# require "#{audio_root}/states/busy"
# require "#{audio_root}/states/available"
# require "#{audio_root}/states/captured"
# require "#{audio_root}/states/overwritten"

# require "#{audio_root}/handlers/cache_handler"
# require "#{audio_root}/handlers/input_handler"
# require "#{audio_root}/listener"

require "#{audio_root}/audio"

puts "\tLoading walter/api/telephone"

telephone_root = 'telephone'
# require "#{audio_root}/states/defaults"
# require "#{audio_root}/states/unknown"
# require "#{audio_root}/states/disabled"
# require "#{audio_root}/states/enabled"
# require "#{audio_root}/states/busy"
# require "#{audio_root}/states/available"
# require "#{audio_root}/states/captured"
# require "#{audio_root}/states/overwritten"

# require "#{audio_root}/handlers/cache_handler"
# require "#{audio_root}/handlers/input_handler"
# require "#{audio_root}/listener"

require "#{telephone_root}/telephone"

puts "\tDone!"
