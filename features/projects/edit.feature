Feature: Projects
  In order to edit my project
  As a scrum master
  I want be able to modify projects
    
    Background: 
      Given I am a user named "foo" with an email "user@test.com" and password "please"
      When I sign in as "user@test.com/please"
      Then I should be signed in
      Given I have project "Test Project"
      When I go to the projects page
      And I follow "Edit"
      Then I should see "Editing `Test Project`"

    Scenario: I want to edit invalid blank project
      And I fill in the following:
         | Name         |  |
         | Alias        |  |
      And I press "Update Project"
      And I should see "Name can't be blank"
      And I should see "Alias can't be blank"

    Scenario: I want to update new invalid alias project
      And I fill in the following:
         | Name  | test      |
         | Alias | test #$#% |
      And I press "Update Project"
      And I should see "Alias is invalid"

      Scenario: I want to update valid project dat
        And I fill in the following:
           | Name         | Test Project |
           | Alias        | test-project |
        And I press "Update Project"
        And I should see "Project was successfully updated."