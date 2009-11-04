Feature: Startup
  As a user
  I should see a document window at app startup
  So I can get to work as soon as possible

  Scenario: Document window at startup
    Given I have started the application
    Then I should see the frame "Document"