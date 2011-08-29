Feature: Projects
  In order to get list of projects
  Should be able to see list of projects
    
    Background: 
      Given I am a user named "foo" with an email "user@test.com" and password "please"
      When I sign in as "user@test.com/please"
      Then I should be signed in
    
    Scenario: As logged user I want to see my projects
      And I go to the projects page
      And I should see "Add project"
      And I should have 0 projects
