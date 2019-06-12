# frozen_string_literal: false

# Comment
class Packet
  attr_reader :from, :to, :data

  def initialize(from, to, data)
    @from = from
    @to = to
    @data = data
  end

  def inspect
    "<Packet Tx: #{from} Rx: #{to} Data: #{data}>"
  end

  def to_s
    "#{from.upcase}\t#{to.upcase}\t#{data}"
  end
end
