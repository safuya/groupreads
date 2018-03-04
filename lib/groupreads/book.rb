module Groupreads
  class Book
    attr_accessor :id, :title, :author, :description, :average_rating, :readers
    KEY = ENV['GOODREADS_KEY']

    def initialize(title)
      self.title = title
      self.readers = []
    end

    def self.new_from_shelf(nokobooki)
      book = new(nokobooki.xpath('title').text)
      book.id = nokobooki.xpath('id').text
      book.description = nokobooki.xpath('description').text
      book.average_rating = nokobooki.xpath('average_rating').text.to_f
      book.author = nokobooki.xpath('authors/author/name').text
      book
    end

    def self.build_url(base_path, params)
      url_params = params.map { |k, v| "#{k}=#{v}" }.join("&")
      "#{base_path}?#{url_params}"
    end

    def self.results(base_path, attributes)
      Nokogiri::XML(open(
        build_url(base_path, attributes)
      ))
    end

    def self.new_from_group(nokobooki)
      book = new(nokobooki.xpath('title').text)
      book.id = nokobooki.xpath('id').text
      book.description = nokobooki.xpath('description').text
      book.average_rating = nokobooki.xpath('average_rating').text.to_f
      book.author = nokobooki.xpath('author/name').text
      book
    end

  end
end
