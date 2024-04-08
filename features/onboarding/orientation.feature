Feature: Onboarding > Orientation
As a new user,
I want to acquaint myself with the features of the app
So that I can effectively make use of its capabilities and features

Scenario: First login
Given I am a new user in the system
When I log in for the first time
And I visit my workspace page
Then a checklist named "Introduction to Obsekio" will be present in my workspace

Scenario: Opening up the "Introduction to Obsekio" checklist
Given I am logged in
And a checklist named "Introduction to Obsekio" exists in my workspace
When I open the checklist named "Introduction to Obsekio"
And I click on the "Account Settings" link in the checklist
Then will be redirected to the account settings page

Scenario: Checking off the "Introduction to Obsekio" checklist
Given I am logged in
And a checklist named "Introduction to Obsekio" exists in my workspace
When I open the checklist named "Introduction to Obsekio"
And I click on the "Review your Account Settings" checklist item
Then the "Review your Account Settings" checklist item will be marked as checked


# Background:
#   Given I have logged on for the first time

# Scenario: User is shown around the app's features
#   Given I am on the home page
#   When I click the "Take a tour" button
#   Then I should see a tour of the app
#   And I should be able to skip the tour

# - [] Look at engagement scenarios
# - [] Look at retention scenarios
# - [] Look at monetization scenarios
# - [] Look at growth scenarios
# - [] Look at user stories, setting up collections, and configuration scenarios


# One idea here is to use an actual checklist to track the progress of the user through the onboarding process, i.e.
# a set of checklist items with links to the relevant parts of the app. This would be a good way to ensure that the
# user is able to effectively navigate the app and make use of its features.
