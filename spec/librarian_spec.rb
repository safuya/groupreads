require 'groupreads'

RSpec.describe Groupreads::Librarian do
  let(:group_books) { ['King Arthur', 'Giant Lazors']}
  let(:user_has_read) { ['King Arthur', 'Hurglegurgle Blaster', 'Cheese Eating for Dummies'] }
  let(:new_books) { Groupreads::Librarian.new_books?(user_has_read, group_books) }
  
  describe '.new_books?' do
    it 'takes two lists of books and returns one list' do
      expect(new_books).to be(Array)
    end

    it 'returns books in the second list not in the first' do
      expect(new_books).to be(['Giant Lazors'])
    end
  end

end
