require 'spec_helper'

RSpec.describe Scraper do

  let(:sword_and_laser) { Scraper.new('4170-the-sword-and-laser') }

  describe '#current_book' do
    it 'is a method that retrieves the book currently being read' do
      expect(sword_and_laser.current_book).to eql('A Wrinkle in Time (A Wrinkle in Time Quintet, #1)')
    end
  end

end
