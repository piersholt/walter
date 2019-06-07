# frozen_string_literal: false

class LogActually
  module Formatter
    include ASCIIColour

    def format_severity(severity)
      format('%-5s', severity)
    end

    def format_progname(progname)
      format('%20s', progname)
    end

    def format_logger_id
      format('%12s', id)
    end

    def format_time(time)
      time.strftime('%H:%M:%S')
    end

    def default_formatter
      proc do |severity, time, progname, msg|
        color = severity_colour(severity)

        formatted_severity = format_severity(severity)
        formatted_time = format_time(time)
        formatted_progname = format_progname(progname)
        formatted_logger_id = format_logger_id

        msg.strip! rescue StandardError

        m = "#{gray}#{formatted_time}#{clear} "\
            "[#{color}#{formatted_severity}#{clear}] "\
            "[#{formatted_logger_id}#{clear}] "\
            "[#{formatted_progname}#{clear}] "\
            "#{msg}#{clear}"
        m.concat("\n") unless severity == Logger::UNKNOWN
      end
    end
  end
end
