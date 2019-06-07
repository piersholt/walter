# frozen_string_literal: false

# TODO
# - EQ Hifi
# - EQ Top HiFi (DSP)

class Vehicle
  # Audio object for vehicle API
  class Audio
    include Singleton
    include Observable

    include LED

    attr_accessor :bus

    def logger
      LogActually.audio
    end

    def to_s
      'Audio'
    end

    # def targets
    #   %i[mfl bmbt]
    # end
  end
end
