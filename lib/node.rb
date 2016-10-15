class Node
  attr_reader :value
  attr_accessor :terminator

  def initialize(value = "", terminator = false)
    @value = value
    @terminator = terminator
  end

  def terminator?
    terminator
  end

end