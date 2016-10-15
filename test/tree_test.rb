require 'minitest/autorun'
require './lib/tree'

require 'pry'

class TreeTest < Minitest::Test

  def test_tree_exists
    assert Tree.new
  end

  def test_a_tree_has_a_root_node_when_created
    test_tree = Tree.new
    assert test_tree.root_node
    binding.pry
  end




end
