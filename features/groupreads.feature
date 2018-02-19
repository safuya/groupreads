Feature: Groupreads
  In order to find new group book reads
  As a reader
  I want to retrieve new books not on my shelf

  Scenario: Add a new user
    When I run `groupreads register 26040396-robert-hughes`
    Then the output should contain "added"

  Scenario: Search for groups
    When I run `groupreads findgroup suffolk`
    Then the output should contain "114317-suffolk-bookclub"

  Scenario: Add a group
    When I run `groupreads addgroup 114317-suffolk-bookclub`
    Then the output should contain "added"

  Scenario: List new group books to read
    When I run `groupreads new`
    Then the output should contain "Your new books are"
