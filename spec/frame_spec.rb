# frame_spec.rb
require 'frame'
require 'byte'
require 'frame_helper'

RSpec.describe Frame do
  # header
      # source / from / sender
    # length
  # payload
      # destination / to / recipient
      # command
      # parameters
  # fcs (frame check sequence) / checksum

  # data link encapsulation.. is SFDs..

  # pysical layer is 1 and 0
  # it can't deal with any concept of frame..
  # so the logic of interfare gap.. and SFDs... is data link (lowest)
  # actually it doesn't come across...
  # it's encapsulated as.. syncrhoinisation exists at a frame level
  # for me it's at a byte level...
  #

  # size
  # to_s

  # HEADER_LENGTH = 2
  # HEADER_INDEX_LENGTH = 2

  # new
  # add_header
  # add_tail

  describe '#initialize' do
    # hash some shit outpu
    # format to expected result and meta test
    let(:frame_tail) { FRAME_TAIL }
    let(:frame) { Frame.new({tail: frame_tail}) }
  end

  describe '#header' do
    it 'should be a method' do
      expect(Frame.new).to respond_to :header
    end

    context 'without a header value' do

    end

    context 'with valid header value' do
      let(:frame_header) { FRAME_HEADER }
      let(:frame) { Frame.new({header: frame_header}) }

      it 'should return an array' do
        header = frame.header
        expect(header).to be_instance_of Array
      end

      it 'should return an array with a length of two' do
        header = frame.header
        header_length = header.length
        expect(header_length).to eq 2
      end

      it 'should return an array with Bytes' do
        header_is_bytes = frame.header.all? { |o| o.instance_of?(Byte) }
        expect(header_is_bytes).to be true
      end
    end
  end

  describe '#payload' do
    let(:frame) { Frame.new(header: FRAME_HEADER, tail: FRAME_TAIL) }

    context 'with valid payload value' do
      it 'should return an array' do
        payload = frame.payload
        expect(payload).to be_instance_of Array
      end

      it 'should return an array with a length of 3' do
        payload = frame.payload
        payload_length = payload.length
        expect(payload_length).to eq 3
      end

      it 'should return an array with Bytes' do
        payload_is_bytes = frame.payload.all? { |o| o.instance_of?(Byte) }
        expect(payload_is_bytes).to be true
      end
    end
  end


  describe '#fcs' do
    let(:frame) { Frame.new(header: FRAME_HEADER, tail: FRAME_TAIL) }

    it 'should be a method' do
      expect(frame).to respond_to :fcs
    end

    it 'should return an Byte' do
      fcs = frame.fcs
      expect(fcs).to be_instance_of Byte
    end

    it 'should return an Byte with hex of 91' do
      fcs = frame.fcs
      expect(fcs.to_h).to eq('91')
    end
  end

  describe '#tail_length' do
    let(:frame) { Frame.new(header: FRAME_HEADER, tail: FRAME_TAIL) }

    it 'should be a method' do
      expect(frame).to respond_to :tail_length
    end

    it 'should return an array' do
      tail_length = frame.tail_length
      expect(tail_length).to eq(4)
    end
  end

end
