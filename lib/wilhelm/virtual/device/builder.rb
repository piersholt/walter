# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      # Comment
      class Builder
        include Wilhelm::Helpers::Module

        CLASS_MAP = {
          dsp: 'Device::DSP::Emulated',
          cdc: 'Device::CDC::Emulated',
          tel: 'Device::Telephone::Emulated',
          rad: 'Device::Radio::Emulated',
          gfx: 'Device::GFX::Augmented',
          dia: 'Device::Diagnostics::Emulated',
          bmbt: 'Device::BMBT::Augmented',
          mfl: 'Device::MFL::Augmented'
        }.freeze

        attr_reader :ident

        def name
          'Device::Builder'
        end

        def target(ident)
          LOGGER.debug(name) { ident }
          raise StandardError, "no class to target #{ident}" unless CLASS_MAP.key?(ident)
          @ident = ident
          self
        end

        def result
          raise StandardError, "no ident set!" unless @ident
          klass_constant = CLASS_MAP[ident]
          klass_constant = prepend_namespace('Wilhelm::Virtual', klass_constant)
          klass = get_class(klass_constant)
          klass.new(ident)
        end
      end
    end
  end
end
