Feature: Onboarding > Sign Up
  As a new user
  I want to be able to set up an account
  So that I can use the app

Background:
  Given I am logged out

Scenario: User signs up
  Given I am on the sign up page
  When I fill in the form with valid information
  And I click the sign up button
  Then I should be redirected to the home page
  And I should see a message prompting me to check my email

Scenario: User confirms email
  Given I have signed up
  When I click the link in the confirmation email
  Then I should be redirected to the sign in page
  And I should see a message confirming my email address

Scenario: User signs up with invalid information
  Given I am on the sign up page
  When I fill in the form with invalid information
  And I click the sign up button
  Then I should see an error message
  And I should still be on the sign up page






