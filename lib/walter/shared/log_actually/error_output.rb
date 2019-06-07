# frozen_string_literal: true

class LogActually
  # Mixin for common error logging output
  module ErrorOutput
    def with_backtrace(logger, error, progname = self.class.name)
      logger.error(progname) { error }
      error.backtrace.each { |line| logger.error(line) }
    end

    def simple(logger, error, progname = self.class.name)
      logger.error(progname) { error }
    end

    def extra(logger, message, progname = self.class.name)
      if progname
        logger.warn(progname) { message }
      else
        logger.warn { message }
      end
    end

    def i(message, progname = self.class.name, logger = :default)
      LogActually.public_send(logger).info(progname) { message }
    end

    def d(message, progname = self.class.name, logger = :default)
      LogActually.public_send(logger).debug(progname) { message }
    end
  end
end
