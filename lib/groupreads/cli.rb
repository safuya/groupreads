require 'thor'
require 'groupreads'

module Groupreads
  class CLI < Thor

    desc "register USER", "Adds a user from id-user-name"
    def register(name)
      reader = Groupreads::Reader.new(name)
      puts "#{reader.username} added."
    end

    desc "findgroup NAME", "Search for a group"
    def findgroup(name)
      groups = Groupreads::Group.search(name)
      groups.each { |group| puts group }
    end
    
  end
end