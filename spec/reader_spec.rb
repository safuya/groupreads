require 'groupreads'

RSpec.describe Groupreads::Reader do
  before(:all) do
    @rob = Groupreads::Reader.new('77948676-robert-hughes')
  end
  let(:jim) { Groupreads::Reader.new('12345678-jim-evans') }

  describe '#username' do
    it 'returns the username and exists on init' do
      expect(@rob.username).to eql('robert-hughes')
      expect(jim.username).to eql('jim-evans')
    end
  end

  describe "#id" do
    it 'returns the id and exists on init' do
      expect(@rob.id).to eql('77948676')
      expect(jim.id).to eql('12345678')
    end
  end

  describe '#read' do
    it 'is a method that returns finished books' do
      rob_read = @rob.read.map { |book| book.title }
      expect(rob_read).to include('The Blade Itself (The First Law, #1)')
    end

    it 'returns more than one page of books' do
      expect(@rob.read.length).to be > 20
    end
  end

  describe '#to_read' do
    it 'is a method that returns to-read books' do
      rob_to_read = @rob.to_read.map { |book| book.title }
      expect(rob_to_read).to include('Simon vs. the Homo Sapiens Agenda')
    end
  end

  describe '#all_books' do
    it 'is a method that returns all finished and to-read books' do
      all_books = @rob.all_books.map { |book| book.title }
      expect(all_books).to include('The Blade Itself (The First Law, #1)')
      expect(all_books).to include('Simon vs. the Homo Sapiens Agenda')
    end
  end

  describe '#list_groups' do
    it 'returns all groups the user is a member of' do
      expect(@rob.list_groups).to include('505999-groupreads-test')
    end
  end

  describe '#group_books' do
    it 'returns the sum of all currently reading books for the users groups' do
      expect(@rob.group_books).to include(
        'The Man in the High Castle'
      )
    end
  end

  describe '#new_books' do
    it 'returns all groups currently reading books not in all_books' do
      expect(@rob.new_books).to include(
        'The Man in the High Castle'
      )
    end
  end

end
