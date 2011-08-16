Feature: Sign up
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up

    Background:
      Given I am not logged in
      And I am on the home page
      And I go to the sign up page

    Scenario: User signs up with valid data
      And I fill in the following:
        | Name                  | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
      And I press "Sign up"
      Then I should see hidden "You have signed up successfully" 
      
    Scenario: User signs up with invalid email
      And I fill in the following:
        | Name                  | Testy McUserton |
        | Email                 | invalidemail    |
        | Password              | please          |
      And I press "Sign up"
      Then I should see "Email is invalid"

    Scenario: User signs up without password
      And I fill in the following:
        | Name                  | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              |                 |
      And I press "Sign up"
      Then I should see "Password can't be blank"
