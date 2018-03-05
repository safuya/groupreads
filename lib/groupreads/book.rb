require 'pry'

module Groupreads
  class Book
    attr_accessor :id, :title, :author, :description, :average_rating
    KEY = ENV['GOODREADS_KEY']
    @@all = []

    def initialize(title, id = nil, author = nil, description = nil, average_rating = nil)
      self.title = title
      self.id = id if id
      self.author = author if author
      self.description = description if description
      self.average_rating = average_rating if average_rating
    end

    def get_all_details
      attributes = {key: KEY}
      base_path = "https://www.goodreads.com/book/show/#{self.id}.xml"
      nokobooki = results(base_path, attributes)
      self.description = nokobooki.xpath('//book/description').text.gsub("<br />", "\n")
      self.average_rating = nokobooki
        .xpath('//GoodreadsResponse/book/average_rating').text.to_f
    end

    def put_details
      if id
        get_all_details
        puts "ID: #{id}"
        puts "Title: #{title}"
        puts "Author: #{author}"
        puts "Description: #{description}"
        puts "Average Rating: #{average_rating}\n\n"
      else
        puts "The book ID is required for this"
      end
    end

    def self.create(title, id = nil, author = nil, description = nil, average_rating = nil)
      book = new(title, id, author, description, average_rating)
      book.save
      book
    end

    def self.find_by_title(title)
      all.detect { |book| book.title == title }
    end

    def self.find_or_create_by_title(title, id = nil, author = nil, description = nil, average_rating = nil)
      if find_by_title(title) then
        find_by_title(title)
      else
        create(title, id, author, description, average_rating)
      end
    end

    def self.all
      @@all
    end

    def save
      self.class.all << self
    end

    def self.find_or_create_from_shelf(nokobooki)
      find_or_create_by_title(
        title = nokobooki.xpath('title').text,
        id = nokobooki.xpath('id').text,
        author = nokobooki.xpath('authors/author/name').text,
        description = nokobooki.xpath('description').text,
        average_rating = nokobooki.xpath('average_rating').text.to_f
      )
    end

    def build_url(base_path, params)
      url_params = params.map { |k, v| "#{k}=#{v}" }.join("&")
      "#{base_path}?#{url_params}"
    end

    def results(base_path, attributes)
      Nokogiri::XML(open(
        build_url(base_path, attributes)
      ))
    end

    def self.find_or_create_from_group(nokobooki)
      find_or_create_by_title(
        title = nokobooki.xpath('title').text,
        id = nokobooki.xpath('id').text,
        author = nokobooki.xpath('author/name').text
      )
    end

  end
end
