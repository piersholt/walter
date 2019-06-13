require 'spec_helper'
require 'frame_helper'
require 'byte'

RSpec.describe Byte do
  let(:invalid_input) { 'hi!' }
  let(:valid_input) { 128.chr }

  describe '#new' do
    it 'should be a valid method' do
      expect(Byte).to respond_to :new
    end

    context 'with valid input' do
      it 'should return instance of Byte' do
        expect(Byte.new(:encoded, valid_input)).to be_instance_of Byte
      end
    end

    context 'with invalid input' do
      it 'should throw error on non string' do
        expect { Wilhelm::Core::Byte.new(invalid_input) }
          .to raise_error ArgumentError
      end

      # A value grater than a byte cannot be Encoding::ASCII_8BIT
      # so it's picked up by the encoding validation
      # it 'should throw error on values larger than one byte' do
      #   expect { Wilhelm::Core::Byte.new(BYTE_ASCII_8BIT_LARGE) }
      #     .to raise_error ArgumentError
      # end
    end
  end

  describe '#to_h' do
    it 'should be a valid method' do
      expect(Byte.new(:encoded, BYTE_ENCODED_0xF0)).to respond_to :to_h
    end

    context 'with hex of \'0x80\'' do
      let(:byte) { Wilhelm::Core::Byte.new(:encoded, BYTE_ENCODED_0x80) }

      it 'should return \'0x80\'' do
        expect(byte.to_h(true)).to eq("0x80")
      end

      it 'should return \'80\'' do
        expect(byte.to_h(false)).to eq("80")
      end
    end

    context 'with hex of \'0xF0\'' do
      let(:byte) { Wilhelm::Core::Byte.new(:encoded, BYTE_ENCODED_0xF0) }

      it 'should return \'0xF0\'' do
        expect(byte.to_h(true)).to eq("0xF0")
      end

      it 'should return \'F0\'' do
        expect(byte.to_h(false)).to eq("F0")
      end
    end

    context 'with hex of \'0x08\'' do
      let(:byte) { Wilhelm::Core::Byte.new(:hex, '08') }

      it 'should return \'0x08\'' do
        expect(byte.to_h(true)).to eq("0x08")
      end

      it 'should return \'08\'' do
        expect(byte.to_h(false)).to eq("08")
      end
    end
  end

  describe '#to_d' do
    it 'should be a valid method' do
      expect(Byte.new(:encoded, BYTE_ENCODED_VALID)).to respond_to :to_d
    end

    context 'with hex of \'0x80\'' do
      let(:byte) { Wilhelm::Core::Byte.new(:encoded, BYTE_ENCODED_0x80) }

      it 'should return 128' do
        expect(byte.to_d).to eq(128)
      end
    end

    context 'with hex of \'0xF0\'' do
      let(:byte) { Wilhelm::Core::Byte.new(:encoded, BYTE_ENCODED_0xF0) }

      it 'should return 240' do
        expect(byte.to_d).to eq(240)
      end
    end
  end

end
