# frozen_string_literal: true

module Messaging
  # Comment
  module API
    include LogActually::ErrorOutput
    include Constants
    include Debug
    include Manager
    include Controller

    # Action
    def messaging_action(command_topic, command_name, properties = {})
      action = Messaging::Action.new(node: Publisher.node, topic: command_topic, name: command_name, properties: properties)
      message_publish(action)
    end

    # Notification
    def messaging_notification(command_topic, command_name, properties = {})
      action = Messaging::Notification.new(node: Publisher.node, topic: command_topic, name: command_name, properties: properties)
      message_publish(action)
    end

    # Client
    def messaging_request(command_topic, command_name, properties = {}, callback)
      action = Messaging::Request.new(topic: command_topic, name: command_name, properties: properties)
      message_request(action, callback)
    end

    # Publisher
    def message_publish(action)
      LogActually.messaging.debug(self.class) { "Publishing: #{action}"}
      Publisher.send!(action)
    rescue StandardError => e
      with_backtrace(LogActually.messaging, e)
    end

    def message_request(action, callback)
      LogActually.messaging.debug(self.class) { "Requesting: #{action}"}
      Client.instance.queue_message(action, callback)
    end

    alias thy_will_be_done! messaging_action
    alias just_lettin_ya_know! messaging_notification
    alias so? messaging_request
    alias fuckin_send_it_lads! message_publish
    alias request_this message_request
  end
end
