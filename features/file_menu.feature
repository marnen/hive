Feature: File menu
  As a user
  I should have commands on the File menu
  So I can easily work with my files

  Scenario: New
    Given I have a new document called "Document-1"
    And the frame "Document-1" is visible
    When I click the menu "File/New"
    Given the file chooser "New" is visible
    When I select the file "New file for test"
    And I approve the file chooser
    Then I should see the frame "New file for test"