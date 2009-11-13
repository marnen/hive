Feature: Table in document
  As a user
  I should have a table interface in any document
  So I can easily work with my data

  Scenario: Table
    Given I have a new document
    And the frame "Document-1" is the container
    Then it should contain a table
    And the table should not be empty