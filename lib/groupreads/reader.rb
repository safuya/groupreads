require 'open-uri'
require 'nokogiri'

module Groupreads
  class Reader
    attr_accessor :username, :id, :key

    def initialize(user)
      self.username = user[/\w+-\w+$/]
      self.id = user[/\d+/]
      self.key = ENV['GOODREADS_KEY']
    end

    def shelf(name)
      res = []
      puts "Goodreads only allow collection of one page per second. Collecting page 1."
      res << Nokogiri::XML(open(
        "https://www.goodreads.com/review/list/#{self.id}.xml?key=#{self.key}&v=2&shelf=#{name}&page=1"
      ))
      iterations = res[0].xpath('//reviews/@total')[0].value.to_f / 20 - 1
      iterations.ceil.times do |i|
        puts "Collecting page #{i + 2} of #{iterations.ceil + 1}."
        res << Nokogiri::XML(open(
          "https://www.goodreads.com/review/list/#{self.id}.xml?key=#{self.key}&v=2&shelf=#{name}&page=#{i + 2}"
        ))
      end
      res
    end

    def read
      shelf('read').map do |page|
        page.xpath('//book/title').map { |book| book.text }
      end.flatten
    end

    def to_read
      shelf('to-read').map do |page|
        page.xpath('//book/title').map { |book| book.text }
      end.flatten
    end

    def all_books
      read + to_read
    end

  end
end
