# frozen_string_literal: false

class Vehicle
  # Telephone object for vehicle API
  class Telephone
    include Singleton
    include Observable

    include LED

    attr_accessor :bus

    def logger
      LogActually.telephone
    end

    def to_s
      'Telephone'
    end

    # TODO: module
    def incoming(caller_id = nil)
      caller_id unless caller_id.nil?
      false
    end
  end
end
