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

end