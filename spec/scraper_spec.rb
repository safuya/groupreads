require 'spec_helper'

RSpec.describe Scraper do

  sword_and_laser = Scraper.new('4170-the-sword-and-laser')

  describe '#scrape_group' do
    it 'is a method that queries the groups show API' do
      expect(sword_and_laser.current_book).to_eql('A Wrinkle in Time (A Wrinkle in Time Quintet, #1)')
    end
  end

end
