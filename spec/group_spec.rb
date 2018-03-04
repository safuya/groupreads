require 'groupreads'

RSpec.describe Groupreads::Group do

  let(:test_group) { Groupreads::Group.new('505999-groupreads-test') }

  describe '#current_books' do
    it 'is a method that retrieves all books currently being read' do
      books = ['The Man in the High Castle', 'Aeneid']
      group_books = test_group.current_books.map { |book| book.title }
      expect(group_books).to eql(books)
    end
  end

end
