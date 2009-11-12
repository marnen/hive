Feature: File menu
  As a user
  I should have commands on the File menu
  So I can easily work with my files

  Scenario: New
    Given the frame "Document-1" is visible
    And I should not see the frame "Document-2"
    When I click the menu "File/New"
    Then I should see the frame "Document-2"