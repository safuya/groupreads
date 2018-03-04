require 'thor'
require 'json'
require 'groupreads'
require 'pry'

module Groupreads
  class CLI < Thor
    
    desc "interactive", "Provides an interactive interface"
    def interactive
      choice = nil
      while choice != "quit" do
        choice = ask("What would you like to do?", limited_to: [
          "register", "list groups", "new books", "quit"])
        if choice == "register"
          user = ask("What is your user name and id (i.e. 26040396-robert-hughes)")
          register(user)
        elsif choice == "list groups"
          listgroups
        elsif choice == "new books"
          newbooks
        end
      end
    end
    
    desc "register USER", "Adds a user from id-user-name"
    def register(name)
      @@reader = Reader.new(name)
      write_config
      puts "#{@@reader.username} added."
    end

    desc "listgroups", "List groups you're a member of"
    def listgroups
      read_config
      @@reader.list_groups.each { |group| puts group }
    end

    desc "newbooks", "List new books not on your to-read or read lists"
    def newbooks
      read_config
      books = @@reader.new_books
      puts "Your new books are:"
      books.each { |book| puts book }
      book_choices = ["no"] + books
      book_choice = ask("View details for a book?\n", limited_to: book_choices)
      books
    end

    private

    CONFIG_FILE = "#{ENV['HOME']}/.groupreads.conf"

    def write_config
      config = {}
      config['username'] = @@reader.username
      config['id'] = @@reader.id
      File.write(CONFIG_FILE, config.to_json)
    end

    def read_config
      begin
        file = File.read(CONFIG_FILE)
        config = JSON.parse(file)
        @@reader = Reader.new("#{config['id']}-#{config['username']}")
      rescue Errno::ENOENT
        puts "No config file. Run groupreads register USER"
      rescue JSON::ParserError
        puts "Invalid config file. Re-run groupreads register USER"
      end
    end

  end
end
