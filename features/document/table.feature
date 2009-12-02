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

  Scenario: Table data is persistent
    Given I have a new document called "Persistent table"
    And the frame "Persistent table" is the container
    When I change the cell at row 5 and column 1 to "new value"
    And I close the frame "Persistent table"
    And the frame "Hive" is visible
    And I click the menu "File/Open"
    And the file chooser "Open" is visible
    And I select the temporary file "Persistent table"
    And I approve the file chooser
    Then I should see the frame "Persistent table"
    Given the frame "Persistent table" is the container
    Then it should contain a table
    And I should see "new value" in the table

  @pending
  Scenario: Table has a name
    Given I have a new document called "Table name"
    And the frame "Table name" is the container
    Then I should see the tab "table1"

  @pending
  Scenario: Row numbers should not scroll separately
    When I can figure out how to write this, I will!  See http://www.jguru.com/faq/view.jsp?EID=87579 .