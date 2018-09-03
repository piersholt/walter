require 'bytes'
require 'frame_components'

class NewFrame < Bytes
  HEADER_LENGTH = 2
  HEADER_INDEX_LENGTH = 2


  # ************************************************************************* #
  #                                  OBJECT
  # ************************************************************************* #

  def inspect
    'test #inspect'
  end

  # ************************************************************************* #
  #                                  FRAME
  # ************************************************************************* #


  def tail=(new_tail)
    @tail = new_tail
    @payload = new_tail[0..-2]
    @fcs = new_tail[-1]
  end

  def tail
    @tail
  end

  # assumes FCS byte present
  def valid?
    raise ArgumentError, 'invalid frame params' unless @header && @tail

    frame_bytes = @frame_header + @frame_tail.without_fcs
    checksum = frame_bytes.reduce(0) do |c,d|
      c^= d.to_d
    end

    checksum == @frame_tail.fcs
  end

  # ************************************************************************* #

  def set_header(header)
    raise ArgumentError unless @frame_header.nil?
    @frame_header = header
    @bytes.insert(0, *@frame_header)
  end

  def set_tail(tail)
    raise ArgumentError unless @frame_tail.nil?
    @frame_tail = tail
    @bytes.insert(-1, *@frame_tail)
  end



  # @deprecated
  def string
    all.map!(&:to_e).join
  end

  # @deprecated
  alias_method :length, :size

  # @deprecated
  def all
    all_frame_components = COMPONENTS_ORDERED.map do |c|
      public_send(c)
    end

    all_frame_components.flatten.compact
  end

  private

  # ************************************************************************* #
  #                                BYTE MAPPING
  # ************************************************************************* #

  def parse_header(header_value)


  end
end
