require 'groupreads'

RSpec.describe Groupreads::Book do

  describe '.find_or_create_from_shelf' do
    it "creates a book from Nokogiri's xml in a shelf" do
      nokobooki = Nokogiri::XML(open("spec/fixtures/book-from-shelf.xml"))
      yayog = Groupreads::Book.find_or_create_from_shelf(nokobooki.xpath('book'))
      expect(yayog.title).to eql("You Are Your Own Gym: The Bible Of Bodyweight Exercises For Men And Women")
      expect(yayog.id).to eql("7907805")
      expect(yayog.average_rating).to eql(3.98)
      expect(yayog.author).to eql("Mark Lauren")
      expect(yayog.description).to include("requires no gym")
    end
  end

  describe '.find_or_create_from_group' do
    it "creates a book from Nokogiri's xml in a group" do
      nokobooki = Nokogiri::XML(open("spec/fixtures/book-from-group.xml"))
      high_castle = Groupreads::Book.find_or_create_from_group(nokobooki.xpath('book'))
      expect(high_castle.title).to eql("The Man in the High Castle")
      expect(high_castle.id).to eql("216363")
      expect(high_castle.author).to eql("Philip K. Dick")
    end
  end

  describe '.find_or_create_by_title' do
    it "creates a book if it's not already created" do
      ted = Groupreads::Book.find_or_create_by_title("Ted")
      expect(ted.title).to eql("Ted")
    end

    it "returns a book if it's already been created" do
      ted = Groupreads::Book.find_or_create_by_title("Ted")
      ted_clone = Groupreads::Book.find_or_create_by_title("Ted")
      expect(ted).to be(ted_clone)
    end
  end

end
