require 'minitest/autorun'
require './lib/node'

class NodeTest < Minitest::Test
  def test_it_exists
    assert(Node.new)
  end

  def test_value_empty
    test_node = Node.new
    assert_equal "", test_node.value
  end

  def test_value_initialized_with_value
    test_node = Node.new("a")
    assert_equal "a", test_node.value
  end

  def test_terminator_defaults_false
    test_node = Node.new
    refute(test_node.terminator?)
  end

  def test_terminator_after_initializing_as_true
    test_node = Node.new("", true)
    assert(test_node.terminator?)
  end

  def test_terminator_after_setting_true
    test_node = Node.new
    test_node.terminator = true
    assert(test_node.terminator?)
  end

  def test_a_node_is_initialized_with_no_children
    test_no_children = Node.new
    refute test_no_children.has_children?
  end

  def test_it_knows_its_own_children
    test_has_child = Node.new
    test_child_node = Node.new
    test_has_child.add_child(test_child_node)
    assert test_has_child.children.include?(test_child_node)
  end

  def test_has_children?
    skip
  end
end
