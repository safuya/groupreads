require 'open-uri'
require 'nokogiri'
require 'pry'

module Groupreads
  class Reader
    attr_accessor :username, :id, :key

    def initialize(user)
      self.username = "robert-hughes"
      self.id = "26040396"
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

  end
end
