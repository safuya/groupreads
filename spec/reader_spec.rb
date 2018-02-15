require 'spec_helper'

RSpec.describe Reader do
  let(:rob) { Reader.new('26040396-robert-hughes') }

  describe '#read' do
    it 'is a method that returns finished books' do
      expect(rob.read).to include('Best Served Cold')
    end
  end
end
