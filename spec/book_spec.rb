require 'groupreads'

RSpec.describe Groupreads::Book do

  let(:test_book) { Groupreads::Book.new('The Wind In The Willows') }

  describe '#title' do
    it 'has a title' do
      expect(test_book.title).to eql('The Wind In The Willows')
    end
  end

  describe '#author' do
    it 'can have an author' do
      test_book.author = 'Kenneth Grahame'
      expect(test_book.author).to eql('Kenneth Grahame')
    end
  end

  describe '#description' do
    it 'has a description' do
      description = "Meet little Mole, willful Ratty, Badger the perennial bachelor, and petulant Toad."
      test_book.description = description
      expect(test_book.description).to eql(description)
    end
  end

  describe '#average_rating' do
    it 'has an average rating' do
      test_book.average_rating = 3.98
      expect(test_book.average_rating).to eql(3.98)
    end
  end

  describe '.new_from_shelf' do
    it "creates a book from Nokogiri's xml in a shelf" do
      nokobooki = Nokogiri::XML(open("spec/fixtures/book-from-shelf.xml"))
      yayog = Groupreads::Book.new_from_shelf(nokobooki.xpath('book'))
      expect(yayog.title).to eql("You Are Your Own Gym: The Bible Of Bodyweight Exercises For Men And Women")
      expect(yayog.id).to eql("7907805")
      expect(yayog.average_rating).to eql(3.98)
      expect(yayog.author).to eql("Mark Lauren")
      expect(yayog.description).to include("requires no gym")
    end
  end

end
