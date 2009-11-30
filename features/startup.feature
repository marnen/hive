Feature: Startup
  As a user
  I should have menus available at app startup
  So I can get to work as soon as possible
  # TODO: At the moment, we're doing this with a splash frame.  I'd like to get rid of that.

  Scenario: Application frame at startup
    Given I have started the application
    Then I should see the frame "Hive"

  Scenario: Application frame has a File menu
    Given the frame "Hive" is visible
    When I click the menu "File/New"
    Given the file chooser "New" is visible
    When I select the temporary file "File menu"
    And I approve the file chooser
    Then I should see the frame "File menu"