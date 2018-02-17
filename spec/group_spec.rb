require 'spec_helper'

RSpec.describe Groupreads::Group do

  let(:sword_and_laser) { Groupreads::Group.new('4170-the-sword-and-laser') }
  let(:suffolk_book_club) { Groupreads::Group.new('114317-suffolk-bookclub') }

  describe '#current_books' do
    it 'is a method that retrieves the book currently being read' do
      snl_books = ['A Wrinkle in Time (A Wrinkle in Time Quintet, #1)']
      expect(sword_and_laser.current_books).to eql(snl_books)
    end

    it 'returns all books if more than one book is currently being read' do
      sbc_books = [
        'Estate Series Box Set',
        'A Storm of Swords (A Song of Ice and Fire, #3)',
        'Midnight at the Bright Ideas Bookstore',
        'Fall of Giants (The Century Trilogy, #1)',
        '11/22/63'
      ]
      expect(suffolk_book_club.current_books).to eql(sbc_books)
    end
  end

end
