require 'groupreads'

RSpec.describe Groupreads::Reader do
  let(:rob) { Groupreads::Reader.new('26040396-robert-hughes') }

  describe '#read' do
    before(:all) do
      robert = Groupreads::Reader.new('26040396-robert-hughes')
      @rob_read = robert.read
    end

    it 'is a method that returns finished books' do
      expect(@rob_read).to include('The Blade Itself (The First Law, #1)')
    end

    it 'returns more than one page of books' do
      expect(@rob_read.length).to be > 20
    end
  end

  describe '#to_read' do
    it 'is a method that returns to-read books' do
      rob_to_read = rob.to_read
      expect(rob_to_read).to include('Simon vs. the Homo Sapiens Agenda')
    end
  end

  describe '#all_books' do
    it 'is a method that returns all finished and to-read books' do
      all_books = rob.all_books
      expect(all_books).to include('The Blade Itself (The First Law, #1)')
      expect(all_books).to include('Simon vs. the Homo Sapiens Agenda')
    end
  end

end
