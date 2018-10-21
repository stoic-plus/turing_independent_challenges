require './test/test_helper'
require './lib/library'
require './lib/author'

class LibraryTest < Minitest::Test
  def setup
    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    @jane_eyre = @charlotte_bronte.add_book("Jane Eyre", "October 16, 1847")
    @villette  = @charlotte_bronte.add_book("Villette", "1853")

    @harper_lee  = Author.new({first_name: "Harper", last_name: "Lee"})
    @mockingbird = @harper_lee.add_book("To Kill a Mockingbird", "July 11, 1960")

    @dpl = Libary.new
  end

  def test_it_exists
    assert_instance_of Libary, @dpl
  end

  def test_it_has_no_books_when_created
    assert_empty @dpl.books
  end

  def test_it_can_receive_books
    assert_empty @dpl.books

    @dpl.add_to_collection(@jane_eyre)
    @dpl.add_to_collection(@mockingbird)
    @dpl.add_to_collection(@villette)

    assert_equal [@jane_eyre, @mockingbird, @villette], @dpl.books
    assert_equal 3, @dpl.books.count
  end
end
