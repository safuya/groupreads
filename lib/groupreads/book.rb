module Groupreads

  class Book
    attr_accessor :id, :title, :author, :description, :average_rating, :readers
    KEY = ENV['GOODREADS_KEY']

    def initialize(title)
      self.title = title
      self.readers = []
    end

    def self.new_by_id(id)
      details = get_xml_by_id(id)
      book = new(details[:title])
      book.id = details[:id]
      book.description = details[:description]
      book.average_rating = details[:average_rating]
      book.author = details[:author]
      book
    end

    def self.get_xml_by_id(id)
      base_path = "https://www.goodreads.com/book/show/#{id}.xml"
      attributes = {key: KEY}
      xml = results(base_path, attributes)
      book = xml.xpath('//book')[0]
      details = {}
      details[:title] = book.xpath('title').text
      details[:id] = id
      details[:description] = book.xpath('description').text
      details[:average_rating] = book.xpath('average_rating').text.to_f
      details[:author] = book.xpath('//author/name')[0].text
      details
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

  end

end
