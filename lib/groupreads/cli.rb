require 'thor'

module Groupreads
  class CLI < Thor

    def register(name)
      reader = Groupreads::Reader.new(name)
      puts "#{reader.username} added."
    end

  end
end