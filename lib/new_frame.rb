require 'bytes'
require 'frame_components'

class ChecksumError < StandardError
end

class NewFrame < Bytes
  PROG_NAME = 'NewFrame'.freeze
  HEADER_LENGTH = 2
  HEADER_INDEX_LENGTH = 2

  FrameHeader.instance_methods(false).each do |header_method|
    def_delegator :header, header_method
  end
  
  FrameTail.instance_methods(false).each do |tail_method|
    def_delegator :tail, tail_method
  end


  # TODO: forward header and tail instance methods to avoid cailling frame.header or frame.tail

  attr_reader :header, :tail

  # ************************************************************************* #
  #                                  OBJECT
  # ************************************************************************* #

  def initialize(bytes = [])
    super(bytes)
  end

  def to_s
    map(&:h).join(' ').to_s
  end

  def inspect
    "<Frame> #{to_s}"
  end

  # ************************************************************************* #
  #                                  FRAME
  # ************************************************************************* #

  def header
    @header ||= Bytes.new
  end

  def tail
    @tail ||= Bytes.new
  end

  def set_header(new_header)
    LOGGER.debug(PROG_NAME) { "#set_header(#{new_header})." }

    LOGGER.debug(PROG_NAME) { "Setting @header." }
    @header = FrameHeader.new(new_header)

    LOGGER.debug(PROG_NAME) { "Updating self with bytes." }
    wholesale(header + tail)
    LOGGER.debug(PROG_NAME) { "self[0..-1]: #{self[0..-1]}" }

    true
  end

  def set_tail(new_tail)
    LOGGER.debug(PROG_NAME) { "#set_tail(#{new_tail})." }

    LOGGER.debug(PROG_NAME) { "Setting @tail." }
    @tail = FrameTail.new(new_tail)

    LOGGER.debug(PROG_NAME) { "Updating self with bytes." }
    wholesale(header + tail)
    LOGGER.debug(PROG_NAME) { "Bytes: #{self[0..-1]}" }

    true
  end

  # ************************************************************************* #
  #                                  FRAME
  # ************************************************************************* #

  def valid?
    LOGGER.debug(PROG_NAME) { "#valid?" }
    raise ArgumentError, '@header or @tail is empty!' if header.empty? || tail.empty?

    frame_bytes = @header + @tail.no_fcs
    checksum = frame_bytes.reduce(0) do |c,d|
      c^= d.to_d
    end

    LOGGER.debug(PROG_NAME) { "Checksum / #{tail.checksum} == #{checksum} => #{checksum == tail.checksum}" }

    checksum == tail.checksum
  end
end
