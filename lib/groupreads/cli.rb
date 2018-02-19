require 'thor'
require 'json'
require 'groupreads'
require 'pry'

module Groupreads
  class CLI < Thor
    
    desc "register USER", "Adds a user from id-user-name"
    def register(name)
      @reader = Groupreads::Reader.new(name)
      write_config
      puts "#{@reader.username} added."
    end

    desc "listgroups", "List groups you're a member of"
    def listgroups
      read_config
      @reader.list_groups.each { |group| puts group }
    end

    private

    CONFIG_FILE = "#{ENV['HOME']}/.groupreads.conf"

    def write_config
      config = {}
      config['username'] = @reader.username
      config['id'] = @reader.id
      File.write(CONFIG_FILE, config.to_json)
    end

    def read_config
      begin
        file = File.read(CONFIG_FILE)
        config = JSON.parse(file)
        @reader = Groupreads::Reader.new("#{config['id']}-#{config['username']}")
      rescue Errno::ENOENT
        puts "No config file. Run groupreads register USER"
      rescue JSON::ParserError
        puts "Invalid config file. Re-run groupreads register USER"
      end
    end

  end
end