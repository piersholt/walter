# frozen_string_literal: true

class LogActually
  # Comment
  class Forrest
    include Singleton

    def loggers
      @loggers ||= {}
    end

    def add(id, logger)
      loggers[id] = logger
      create_method(id)
      true
    end

    def remove(id)
      loggers.delete(id)
    end

    private

    def create_method(id)
      LogActually.class.send(:define_method, id) do
        Forrest.instance.loggers[id]
      end
    end
  end
end
