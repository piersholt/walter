# frozen_string_literal: true

require_relative 'generate'
require_relative 'parse'

module Wilhelm
  module Virtual
    class Command
      # Basic device class
      class Base
        include Wilhelm::Helpers::DataTools
        include Helpers
        include Generate

        NAME           = 'Command::Base'
        DEVICE_UNKNOWN = '???'
        ARGS_EMPTY     = '--'
        MASK_NAME      = '%-10s'
        MASK_BINARY    = '%8.8b'
        MASK_HEX       = '%2.2x'
        PADDED_DEFAULT = true

        attr_accessor :id, :short_name, :long_name, :arguments, :verbose

        alias address id
        alias ln      long_name
        alias args    arguments

        def initialize(id, props)
          LOGGER.debug(NAME) { "#initialize(#{id}, #{props})" }
          @id = id
          add_properties(props)
        end

        alias normal_fucking_decimal id

        def ==(other)
          id == other.id
        end

        # ------------------------------ OBJECT ----------------------------- #

        def to_s
          return inspect if @verbose
          abvr = short_name == DEVICE_UNKNOWN ? h : short_name
          str_buffer = format(MASK_NAME, abvr)
          str_buffer.concat("\t#{@arguments}") unless @arguments.empty?
          str_buffer.concat("\t#{ARGS_EMPTY}") if @arguments.empty?
          str_buffer
        end

        def inspect
          str_buffer = format(MASK_NAME, sn)
          str_buffer.concat("\t#{@arguments}") unless @arguments.empty?
          str_buffer.concat(ARGS_EMPTY) if @arguments.empty?
          str_buffer
        end

        # --------------------------- PROPERTIES ---------------------------- #

        alias d id

        def b
          @b ||= format(MASK_BINARY, @id)
        end

        def h
          @h ||= format(MASK_HEX, @id)
        end

        def sn(padded = PADDED_DEFAULT)
          padded ? format(MASK_NAME, short_name) : short_name
        end

        def var_set(hash)
          hash.each do |name, value|
            instance_variable_set(inst_var(name), value)
          end
        end

        alias add_properties var_set
      end
    end
  end
end
