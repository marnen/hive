Feature: Startup
  As a user
  I should see a document window at app startup
  So I can get to work as soon as possible

  @pending
  Scenario: New document at startup
    Given I have started the application
    And the file chooser "New" is visible
    When I select the file "Document-1"
    And I approve the file chooser
    Then I should see the frame "Document-1"