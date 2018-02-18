require 'groupreads'

RSpec.describe Groupreads::Reader do
  before(:all) do
    rob = Groupreads::Reader.new('26040396-robert-hughes')
    @rob_read = rob.read
  end

  describe '#read' do
    it 'is a method that returns finished books' do
      expect(@rob_read).to include('The Blade Itself (The First Law, #1)')
    end

    it 'returns more than one page of books' do
      expect(@rob_read.length).to be > 20
    end
  end
end
