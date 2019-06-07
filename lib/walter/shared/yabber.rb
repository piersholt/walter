# frozen_string_literal: true

# require 'log_actually'

# Yabber
LogActually.is_all_around(:messaging)
LogActually.messaging.i
LogActually.is_all_around(:client)
LogActually.client.i
LogActually.is_all_around(:publisher)
LogActually.publisher.i
LogActually.is_all_around(:server)
LogActually.server.i
LogActually.is_all_around(:subscriber)
LogActually.subscriber.i

require 'singleton'
require 'json'

require_relative 'yabber/manageable_threads'

require_relative 'yabber/constants'
require_relative 'yabber/defaults'
require_relative 'yabber/validation'
require_relative 'yabber/object_validation'
require_relative 'yabber/printable'

require_relative 'yabber/message/base_message'
require_relative 'yabber/message/action'
require_relative 'yabber/message/notification'
require_relative 'yabber/message/request'
require_relative 'yabber/message/reply'

require_relative 'yabber/klasses'
require_relative 'yabber/serialization'
require_relative 'yabber/message/serialized'

require_relative 'yabber/queue/thread_safe'
require_relative 'yabber/queue/announce'
require_relative 'yabber/queue/messaging_queue'
require_relative 'yabber/queue/publisher'
require_relative 'yabber/queue/subscriber'
require_relative 'yabber/queue/server'
require_relative 'yabber/queue/client'

require_relative 'yabber/api/debug'
require_relative 'yabber/api/manager'
require_relative 'yabber/api/controller'
require_relative 'yabber/api/api'

require_relative 'yabber/delegation/chain_errors'
require_relative 'yabber/delegation/delegate_validation'
require_relative 'yabber/delegation/notification_delegate_validation'
require_relative 'yabber/delegation/notification_delegate'
require_relative 'yabber/delegation/notification_delegator'
require_relative 'yabber/delegation/notification_handler'
