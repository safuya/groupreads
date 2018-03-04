require 'open-uri'
require 'nokogiri'

module Groupreads
  class Group
    attr_accessor :name, :key, :current_books

    def initialize(name)
      self.name = name
      self.key = ENV['GOODREADS_KEY']
    end

    def show
      show ||= Nokogiri::XML(open(
        "https://www.goodreads.com/group/show/#{self.name}.xml?key=#{self.key}"
      ))
    end

    def current_books
      show.xpath('//currently_reading/group_book/book').map do |book|
        book = Groupreads::Book.new_from_group(book)
      end
    end

  end
end
