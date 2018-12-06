# frozen_string_literal: true

# Comment
class Virtual
  class DynamicDeviceBuilder
    include ModuleTools

    CLASS_MAP = {
      dsp: 'SimulatedDSP',
      cdc: 'SimulatedCDC',
      tel: 'SimulatedTEL',
      rad: 'AugmentedRAD'
    }.freeze

    attr_reader :ident

    def target(ident)
      raise StandardError, "no class to target #{ident}" unless CLASS_MAP.key?(ident)
      @ident = ident
      self
    end

    def result
      raise StandardError, "no ident set!" unless @ident
      klass_constant = CLASS_MAP[ident]
      klass_constant = prepend_namespace('Virtual', klass_constant)
      klass = get_class(klass_constant)
      klass.new(ident)
    end
  end
end
