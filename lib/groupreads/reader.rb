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
      base_path = "https://www.goodreads.com/review/list/#{self.id}.xml"
      attributes = {key: self.key, v: 2, shelf: name}
      root = "reviews"
      results(base_path, attributes, root)
    end

    def results(base_path, attributes, root)
      res = []
      puts "Goodreads only allow collection of one page per second. Collecting page 1."
      res << Nokogiri::XML(open(
        build_url(base_path, attributes)
      ))

      iterations = res[0].xpath("//#{root}/@total")[0].value.to_f / 20 - 1
      iterations.ceil.times do |i|
        puts "Collecting page #{i + 2} of #{iterations.ceil + 1}."
        attributes[:page] = i + 2
        res << Nokogiri::XML(open(
          build_url(base_path, attributes)
        ))
      end

      res
    end

    def read
      @read ||= shelf('read').map do |page|
        page.xpath('//book/title').map { |book| book.text }
      end.flatten
    end

    def to_read
      @to_read ||= shelf('to-read').map do |page|
        page.xpath('//book/title').map { |book| book.text }
      end.flatten
    end

    def all_books
      read + to_read
    end

    def list_groups
      if @list_groups
        return @list_groups
      end
      
      base_path = "https://www.goodreads.com/group/list/#{self.id}.xml"
      attributes = {key: self.key}
      root = "list"
      
      results(base_path, attributes, root)

      @list_groups = results(base_path, attributes, root).map do |groups|
        groups.xpath('//group/link').map do |group|
          group.text.gsub('https://www.goodreads.com/group/show/', '')
        end
      end.flatten      
    end

    def build_url(base_path, params)
      url_params = params.map { |k, v| "#{k}=#{v}" }.join("&")
      "#{base_path}?#{url_params}"
    end

    def group_books
      @group_books ||= list_groups.map do |group|
        g = Groupreads::Group.new(group)
        g.current_books
      end.flatten
    end

    def new_books
      group_books - all_books
    end
    
  end
end
