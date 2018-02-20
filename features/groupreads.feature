Feature: Groupreads
  In order to find new group book reads
  As a reader
  I want to retrieve new books not on my shelf

  Scenario: Add a new user
    When I run `groupreads register 26040396-robert-hughes`
    Then the output should contain "added"

  Scenario: List groups the user is a member of
    When I run `groupreads listgroups`
    Then the output should contain "114317-suffolk-bookclub"

  Scenario: List new group books to read
    When I run `groupreads newbooks`
    Then the output should contain "Your new books are"
