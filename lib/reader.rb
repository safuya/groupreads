require 'open-uri'
require 'nokogiri'
require 'pry'

class Reader
  attr_accessor :username, :id, :key

  def initialize(user)
    self.username = "robert-hughes"
    self.id = "26040396"
    self.key = ENV['GOODREADS_KEY']
  end

  def shelf(name)
    res = []
    res << Nokogiri::XML(open(
      "https://www.goodreads.com/review/list/#{self.id}.xml?key=#{self.key}&v=2&shelf=#{name}&page=1"
    ))
    iterations = res[0].xpath('//reviews/@total')[0].value.to_f / 20 - 1
    iterations.ceil.times do |i|
      res << Nokogiri::XML(open(
        "https://www.goodreads.com/review/list/#{self.id}.xml?key=#{self.key}&v=2&shelf=#{name}&page=#{i + 2}"
      ))
    end
    res
  end

  def read
    t = shelf('read').xpath('/title')
  end

end
