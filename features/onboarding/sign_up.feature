Feature: Onboarding > Sign Up
  As a new user, I want to be able to set up an account so that I can use the app.

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

# Scenario: User is shown around the app's features
#   Given I am on the home page
#   When I click the "Take a tour" button
#   Then I should see a tour of the app
#   And I should be able to skip the tour


# - [] Look at engagement scenarios
# - [] Look at retention scenarios
# - [] Look at monetization scenarios
# - [] Look at virality scenarios
# - [] Look at growth scenarios
# - [] Look at user stories, setting up collections, and configuration scenarios




