# frozen_string_literal: true

class Wilhelm::Virtual
  class Message
    attr_accessor :from, :to, :command

    alias :receiver :to
    alias :sender :from

    def initialize(from, to, command)
      @from = from
      @to = to
      @command = command
    end

    def to_s
      begin
        return inspect if command.verbose
        "#{from}\t#{to}\t#{command}"
      rescue StandardError => e
        LOGGER.error(PROC) { "#{e}" }
        e.backtrace.each { |l| LOGGER.error(PROC) { l } }
        binding.pry
      end
    end

    def inspect
      "#{from}\t#{to}\t#{command.inspect}"
    end

    def from?(ident)
      from == ident
    end

    def to?(ident)
      to == ident
    end
  end
end
