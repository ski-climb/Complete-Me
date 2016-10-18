require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/complete_me'

class CompleteMeTest < Minitest::Test

  def test_it_exists
    assert CompleteMe.new
  end

  def test_it_can_insert_one_word_at_a_time
    completion = CompleteMe.new
    completion.insert('pizza')
    assert_equal 1, completion.count
  end

  def test_it_can_suggest_a_word_if_one_word_is_in_tree
    completion = CompleteMe.new
    completion.insert('pizza')
    assert_equal ['pizza'], completion.suggest('piz')
  end

  def test_suggest_if_chunk_does_not_match_the_one_word_in_tree
    completion = CompleteMe.new
    completion.insert('pizza')
    #Left expected value intentionally as "pizza" so we can see the actual returned value
    assert_equal ['pizza'], completion.suggest('magy')
  end

  def test_suggest_if_chunk_does_not_match_any_word_in_small_dictionary
    completion = CompleteMe.new
    dictionary = File.read("./test/small_dictionary.txt")
    completion.populate(dictionary)
    assert_equal ['pizza'], completion.suggest('magy')
  end

  def test_it_can_import_a_whole_dictionary_of_words_at_once
    skip
    completion = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    completion.populate(dictionary)
    assert_equal 235886, completion.count
  end

  def test_it_can_suggest_a_word_when_many_words_are_in_the_tree
    skip
    completion = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    completion.populate(dictionary)
    assert_equal ["pizza", "pizzeria", "pizzicato", "pizzle", "pize"].sort, completion.suggest('piz')
  end

  def test_it_weights_suggested_words_based_on_previous_selection
    skip
    completion = CompleteMe.new
    completion.insert('pizzeria')
    completion.insert('pizza')
    completion.insert('pizzicato')
    3.times { completion.select('piz', 'pizzeria')  }
    2.times { completion.select('pi',  'pizza')     }
    1.times { completion.select('pi', 'pizzicato') }
    assert_equal ['pizzeria', 'pizza', 'pizzicato'], completion.suggest('piz')
    assert_equal ['pizza', 'pizzicato', 'pizzeria'], completion.suggest('pi')
  end

    def test_suggest_and_select_with_whole_dictionary
    skip
    completion = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    completion.populate(dictionary)
    assert_equal ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"], completion.suggest('piz')
    completion.select("piz", "pizza")
    assert_equal ["pizza", "pize", "pizzeria", "pizzicato", "pizzle"], completion.suggest('piz')
    completion.select("pi", "pizzicato")
    assert_equal ["pizza", "pize", "pizzeria", "pizzicato", "pizzle"], completion.suggest('mag')
  end

end
