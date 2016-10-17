require 'minitest/autorun'
require './lib/node'

class NodeTest < Minitest::Test
  def test_node_exists
    assert(Node.new)
  end

  def test_letter_empty
    test_node = Node.new
    assert_equal "", test_node.letter
  end

  def test_letter_initialized_with_letter
    test_node = Node.new("a")
    assert_equal "a", test_node.letter
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
    test_node.set_terminator
    assert(test_node.terminator?)
  end

  def test_has_child_of_node_without_children
    test_has_child = Node.new
    test_child_letter = "a"
    refute test_has_child.has_child?(test_child_letter)
  end

  def test_node_can_have_one_child
    test_has_child = Node.new
    test_child_letter = "a"
    test_has_child.add_child(test_child_letter)
    assert test_has_child.has_child?(test_child_letter)
  end

  def test_node_can_have_more_than_one_child
    test_has_children = Node.new
    test_first_child_letter = "a"
    test_second_child_letter = "b"
    test_has_children.add_child(test_first_child_letter)
    test_has_children.add_child(test_second_child_letter)
    assert test_has_children.has_child?(test_first_child_letter)
    assert test_has_children.has_child?(test_second_child_letter)
  end

  def test_a_node_is_initialized_with_no_children
    test_no_children = Node.new
    refute test_no_children.has_children?
  end

  def test_has_children_returns_true_when_node_has_child_nodes
    test_has_children = Node.new
    test_first_child_letter = "a"
    test_second_child_letter = "b"
    test_has_children.add_child(test_first_child_letter)
    test_has_children.add_child(test_second_child_letter)
    assert test_has_children.has_children?
  end

  def test_node_is_leaf
    test_leaf_node = Node.new
    test_leaf_node.set_terminator
    assert test_leaf_node.is_leaf?
  end

  def test_node_is_not_leaf
    test_leaf_node = Node.new
    refute test_leaf_node.is_leaf?
  end

  def test_node_add_selected_suggestion_to_empty_list_of_previously_selected_suggestions
    test_add_selected_suggestion_node = Node.new
    test_add_selected_suggestion_node.add_selected_suggestion("cat")
    assert_equal [[1, "cat"]], test_add_selected_suggestion_node.selected_suggestions
  end

  def test_node_add_selected_suggestion_into_not_empty_list_of_previously_selected_suggestions
    test_adding_two_selected_suggestions_node = Node.new
    test_adding_two_selected_suggestions_node.add_selected_suggestion("cat")
    test_adding_two_selected_suggestions_node.add_selected_suggestion("cattle")
    assert_equal [[1, "cat"], [1, "cattle"]], test_adding_two_selected_suggestions_node.selected_suggestions
  end


  def test_node_add_selected_suggestion_with_same_word_is_already_included_in_list_of_previously_selected_suggestions
    skip
  end

end
