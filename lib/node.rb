module Comparable
  def compare(first_node, second_node)
    return first_node.data == second_node.data
  end
end

class Node 
  attr_accessor :data, :left, :right

  def initialize(data=nil)
    @data = data
    @left = nil
    @right = nil
  end

  include Comparable
end