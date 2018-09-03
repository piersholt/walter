require 'bytes'
require 'frame_components'

class NewFrame < Bytes
  HEADER_LENGTH = 2
  HEADER_INDEX_LENGTH = 2

  COMPONENTS = [:header, :payload, :fcs].freeze

  COMPONENT_PROPERTIES = {
    header: { position: 0, length: 2 },
    payload: { position: 1, offset: 2, length: nil },
    fcs: { position: 2, offset: -1, length: 1 } }.freeze

  COMPONENTS_ORDERED = COMPONENTS.sort do |a, b|
    c1 = COMPONENT_PROPERTIES[a]
    c2 = COMPONENT_PROPERTIES[b]
    c1[:position] <=> c2[:position]
  end

  COMPONENTS_ORDERED.each { |e| attr_accessor e }

  attr_accessor :header
  attr_reader :payload
  attr_accessor :fcs

  attr_reader :tail_length

  # ************************************************************************* #
  #                                  OBJECT
  # ************************************************************************* #

  def initialize(args = {})
    public_send(:header=, args[:header]) if args.has_key? :header
    public_send(:payload=, args[:payload]) if args.has_key? :payload
    public_send(:tail=, args[:tail]) if args.has_key? :tail
    super
  end

  # def inspect
  #   frame_components_grouped = COMPONENTS_ORDERED.map do |c|
  #     component = public_send(c)
  #     # LOGGER.warn(component)
  #     str_bfr = component.respond_to?(:join) ? component.join(' ') : component
  #     "[#{str_bfr}]"
  #   end.join(' ')
  #
  #   sprintf("%-10s", "[Frame]").concat(frame_components_grouped)
  # end

  # def to_s
  #   complete_frame = all
  #   return 'No data' if all.size.zero?
  #   string = all.reduce('') { |s, b| s.concat("#{b} ") }
  #   string
  # end

  # def to_s
  #   complete_frame = all
  #   return 'No data' if all.size.zero?
  #   string = all.reduce('') { |s, b| s.concat("#{b} ") }
  #   string
  # end

  def to_s
    'test #to_s'
  end

  def inspect
    'test #inspect'
  end

  # ************************************************************************* #
  #                                  FRAME
  # ************************************************************************* #

  def header=(new_header)
    @header = new_header
    @tail_length = new_header[1].to_d
  end

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

  # ************************************************************************* #
  #                                OBSOLETE
  # ************************************************************************* #

  # @deprecated
  def header_s
    @header.reduce('') { |s, o| s.concat("#{o} ") }
  end

  # @deprecated
  def tail_s
    @tail.reduce('') { |s, b| s.concat("#{b} ") }
  end

  # @deprecated
  def size
    all.size
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
