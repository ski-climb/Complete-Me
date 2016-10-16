require 'minitest/autorun'
require './lib/importer'

class ImporterTest < Minitest::Test
  def test_importer_exists
    assert Importer.new 
  end

  def test_importer_imports_zero_words_when_file_empty
    test_importer = Importer.new
    test_file = File.read('./test/empty_file.txt')
    test_importer.import(test_file)
    assert_equal 0, test_importer.imported_word_count
  end

  def test_importer_imports_one_word_when_file_has_one_word
    test_importer = Importer.new
    test_file = File.read('./test/test_input_file1.txt')
    test_importer.import(test_file)
    assert_equal 1, test_importer.imported_word_count
  end

end