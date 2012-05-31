Feature: Sign up
  In order to get access to protected sections of the site
  A user
  Should be able to sign up

  Scenario: User signs up with valid data
    Given I am not logged in
    When I go to the sign up page
    And I fill in "Name" with "John"
    And I fill in "Email" with "JohnSmith@gmail.com"
    And I fill in "Password" with "foobar"
    And I fill in "Password confirmation" with "foobar"
    And I press "Sign up"
    Then I should be signed in
