require 'groupreads/group'
require 'groupreads/reader'

module Groupreads
  class Librarian

    def self.new_books(user_books, group_books)
      group_books - user_books
    end

  end
end
