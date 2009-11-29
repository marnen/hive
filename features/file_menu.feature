Feature: File menu
  As a user
  I should have commands on the File menu
  So I can easily work with my files

  Scenario: New
    Given I have a new document called "Document-1"
    And the frame "Document-1" is visible
    When I click the menu "File/New"
    Given the file chooser "New" is visible
    When I select the temporary file "New file for test"
    And I approve the file chooser
    Then I should see the frame "New file for test"
    And I should have a temporary file called "New file for test"

  Scenario: Open
    Given I have a temporary file called "File to open"
    And I have a new document called "Document-1"
    And the frame "Document-1" is visible
    When I click the menu "File/Open"
    Given the file chooser "Open" is visible
    When I select the temporary file "File to open"
    And I approve the file chooser
    Then I should see the frame "File to open"
