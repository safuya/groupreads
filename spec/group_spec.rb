require 'groupreads'

RSpec.describe Groupreads::Group do

  let(:test_group) { Groupreads::Group.new('505999-groupreads-test') }

  describe '#current_books' do
    it 'is a method that retrieves all books currently being read' do
      books = ['The Man in the High Castle', 'Aeneid']
      group_books = test_group.current_books.map { |book| book.title }
      expect(group_books).to eql(books)
    end

    it 'returns all the correct details for a book' do
      book = test_group.current_books.first
      expect(book.title).to eql("The Man in the High Castle")
      expect(book.id).to eql("216363")
      expect(book.author).to eql("Philip K. Dick")
    end
  end

end
