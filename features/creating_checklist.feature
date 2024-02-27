Feature: Creating checklists
As a user I want to be able to create checklists so that I can track of repeatable tasks

Background:
  Given I am on the home page
  And I am logged in

Scenario: Creating a checklist
  When I click on the "Create a checklist" link
  And I fill in "Title" with "My first checklist"
  And I click on the "Create" button
  Then I should see "My first checklist" in the list of checklists

Scenario: Creating a checklist with no title
  When I click on the "Create a checklist" link
  And I click on the "Create" button
  Then I should see "Title can't be blank" in the list of errors

Scenario: Creating a checklist with a duplicate title
  Given I have a checklist called "My first checklist"
  When I click on the "Create a checklist" link
  And I fill in "Title" with "My first checklist"
  And I click on the "Create" button
  Then I should see "Title has already been taken" in the list of errors
