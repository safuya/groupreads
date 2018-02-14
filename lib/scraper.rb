require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :name, :key

  def initialize(name)
    self.name = name
    self.key = ENV['GOODREADS_KEY']
  end

  def group_show
    Nokogiri::XML(open(
      "https://www.goodreads.com/group/show/#{self.name}.xml?key=#{self.key}"
    ))
  end

  def current_book
    group_details = group_show
    group_details.xpath('//currently_reading')
    binding.pry
  end

end
