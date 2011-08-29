Feature: Projects
  In order to get list of projects
  Should be able to see list of projects
    
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

    
    Scenario: I want to create new valid project
      When I go to the projects page
      And I follow "Add project"
      Then I should see "New project"
      And I fill in the following:
         | Name         | Test Project |
         | Alias        | test-project |
      And I press "Create Project"
      And I should see "Project was successfully created."

      
    Scenario: I want to create new invalid alias project
      When I go to the projects page
      And I follow "Add project"
      Then I should see "New project"
      And I fill in the following:
         | Name         | test |
         | Alias        | test #$#% |
      And I press "Create Project"
      And I should see "Alias is invalid"
      
    Scenario: After creating project it should have sprint and 3 states
      Given the following project records
        | name  | alias |
        | Test Project | test-project |
      When I go to the projects page
      And I should see "Test Project"
