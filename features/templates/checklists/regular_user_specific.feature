Feature: Templates > Checklists > Regular User Specific
As a regular user,
I want to access a library of templates for checklists,
So that I can quickly add a checklist to my library for a specific purpose.

Background:
Given I am a logged in as a regular user

Scenario: User accesses the template checklist library
Given I am on the dashboard
When I click on the "Templates" link
Then I should be taken to the template checklist library

Scenario: User selects a template
Given a published template checklist called "Test" exists
And I am on the template checklist library
When I click on a template checklist called "Test"
Then I should be taken to the template checklist view page

Scenario: User copies a template to their own library
Given a published template checklist called "Test" exists
And I am on the template checklist view page
When I click on "Copy to Library"
Then I should see a success message
And the copied checklist should be in my library
