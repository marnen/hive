Feature: Table in document
  As a user
  I should have a table interface in any document
  So I can easily work with my data

  Scenario: Table is present in new document
    Given I have a new document called "Document-1"
    And the frame "Document-1" is the container
    Then it should contain a table
    And the table should not be empty

  Scenario: Table is editable
    Given I have a new document called "Document-1"
    And the frame "Document-1" is the container
    When I change the cell at row 3 and column 2 to "new value"
    Then I should see "new value" in the table

  Scenario: Row numbers should not scroll separately
    When I can figure out how to write this, I will!  See http://www.jguru.com/faq/view.jsp?EID=87579 .