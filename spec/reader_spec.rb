require 'spec_helper'

RSpec.describe Reader do
  let(:rob) { Reader.new('26040396-robert-hughes') }
  let(:rob_read) { rob.read }

  describe '#read' do
    it 'is a method that returns finished books' do
      expect(rob_read).to include('Best Served Cold')
    end

    it 'returns more than one page of books' do
      expect(rob_read.length).to be > 20
    end
  end
end
