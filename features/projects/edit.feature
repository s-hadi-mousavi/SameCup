Feature: Projects
  In order to edit my project
  As a scrum master
  I want be able to modify projects
    
    Background: 
      Given I am a user named "foo" with an email "user@test.com" and password "please"
      When I sign in as "user@test.com/please"
      Then I should be signed in
      Given I have project "Test Project"

      Scenario: I want to be able to edit project
        When I go to the projects page
        And I follow "Edit"
        Then I should see "Editing `Test Project`"
