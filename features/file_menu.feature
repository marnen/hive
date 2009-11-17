Feature: File menu
  As a user
  I should have commands on the File menu
  So I can easily work with my files

  Scenario: New brings up a file creation dialog
    Given the frame "Document-1" is visible
    And I click the menu "File/New"
    And the file chooser "New" is visible
    And the file chooser "New" is the container
    When I click the button "Cancel"