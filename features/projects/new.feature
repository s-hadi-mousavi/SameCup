Feature: Projects
  In order to get list of projects
  As a authorized user
  I want be able to create new projects
    
    Background: 
      Given I am a user named "foo" with an email "user@test.com" and password "please"
      When I sign in as "user@test.com/please"
      Then I should be signed in

    Scenario: I want to create new invalid blank project
      When I go to the projects page
      And I follow "Add project"
      Then I should see "New project"
      And I fill in the following:
         | Name         |  |
         | Alias        |  |
      And I press "Create Project"
      And I should see "Name can't be blank"
      And I should see "Alias can't be blank"
      
    Scenario: I want to create new invalid alias project
      When I go to the projects page
      And I follow "Add project"
      Then I should see "New project"
      And I fill in the following:
         | Name  | test      |
         | Alias | test #$#% |
      And I press "Create Project"
      And I should see "Alias is invalid"
      
      Scenario: I want to create new valid project
        When I go to the projects page
        And I follow "Add project"
        Then I should see "New project"
        And I fill in the following:
           | Name         | Test Project |
           | Alias        | test-project |
        And I press "Create Project"
        And I should see "Project was successfully created."
        And project should have states