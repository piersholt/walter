# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      # Device::Builder
      class Builder
        include Wilhelm::Helpers::Module

        NAME = 'Device::Builder'.freeze

        ANCESTORS = %w[Wilhelm Virtual Device].freeze

        TYPES_MAP = {
          base: 'Base',
          emulated: 'Emulated',
          augmented: 'Augmented'
        }.freeze

        CLASS_MAP = {
          bmbt: 'BMBT',
          cdc: 'CDC',
          cid: 'CID',
          dia: 'Diagnostics',
          dsp: 'DSP',
          gm:  'GM',
          gt:  'GT',
          gt2: 'GT2',
          ike: 'IKE',
          lcm: 'LCM',
          mfl: 'MFL',
          mid: 'MID',
          nav: 'Navigation',
          rad: 'Radio',
          rcc: 'RadioControlledClock',
          rcm: 'RCM',
          ses: 'SES',
          tcu: 'TCU',
          tel: 'Telephone',
          tv: 'TV'
        }.freeze

        attr_reader :ident, :klass

        def name
          NAME
        end

        def target(ident)
          LOGGER.debug(name) { ident }
          validate_target(ident)
          @ident = ident
          self
        end

        def type(klass)
          validate_type(klass)
          @klass = TYPES_MAP[klass]
          self
        end

        def result
          validate_parameters
          klass_constant = join_namespaces(*ANCESTORS, CLASS_MAP[ident], klass)
          klass = get_class(klass_constant)
          klass.new(ident)
        end

        def validate_parameters
          return true if ident && klass
          raise(ArgumentError, 'Parameters not set!'\
                               "Ident: #{ident ? ident : 'nil!'},"\
                               "Klass: #{klass ? klass : 'nil!'}")
        end

        def validate_type(klass)
          return true if valid_type?(klass)
          raise(ArgumentError, "Type must be one of: #{TYPES_MAP.keys}")
        end

        def validate_target(ident)
          return true if valid_target?(ident)
          raise(ArgumentError, "Target must be one of: #{CLASS_MAP.keys}")
        end

        def valid_type?(klass)
          TYPES_MAP.key?(klass)
        end

        def valid_target?(ident)
          CLASS_MAP.key?(ident)
        end
      end
    end
  end
end
