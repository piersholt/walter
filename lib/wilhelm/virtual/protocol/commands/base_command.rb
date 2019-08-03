# frozen_string_literal: false

require_relative 'generate'
require_relative 'parse'

module Wilhelm
  module Virtual
    class Command
      # Basic device class
      class BaseCommand
        include Wilhelm::Helpers::DataTools
        include Helpers
        include Generate

        MASK_BINARY    = '%8.8b'
        MASK_HEX       = '%2.2x'
        PADDED_DEFAULT = true

        attr_accessor :id, :short_name, :long_name, :arguments, :verbose

        alias :address :id
        alias :ln :long_name
        alias :args :arguments

        def initialize(id, props)
          LOGGER.debug("BaseCommand") { "#initialize(#{id}, #{props})" }
          @id = id
          set_properties(props)
        end

        def normal_fucking_decimal
          id
        end

        def ==(other_command)
          id == other.id
        end

        # -------------------------------- OBJECT ------------------------------- #

        def to_s
          return inspect if @verbose
          abvr = short_name == '???' ? h : short_name
          str_buffer = sprintf("%-10s", abvr)
          args_str_buffer = @arguments.map(&:h).join(' ')
          str_buffer.concat("\t#{args_str_buffer}") unless args_str_buffer.empty?
          str_buffer.concat("\t--") if args_str_buffer.empty?
          str_buffer
        end

        def inspect
          str_buffer = sprintf("%-10s", sn)
          args_str_buffer = @arguments.map(&:h).join(' ')
          str_buffer.concat("\t#{args_str_buffer}") unless args_str_buffer.empty?
          str_buffer.concat("--") if args_str_buffer.empty?
          str_buffer
        end

        # ----------------------------- PROPERTIES ------------------------------ #

        alias d id

        def b
          @b ||= format(MASK_BINARY, @id)
        end

        def h
          @h ||= format(MASK_HEX, @id)
        end

        def sn(padded = PADDED_DEFAULT)
          padded ? sprintf("%-10s", short_name) : short_name
        end

        def set_parameters(params)
          set_properties(params)
        end

        private

        def set_properties(props)
          props.each do |name, value|
            instance_variable_set(inst_var(name), value)
          end
        end
      end
    end
  end
end
