Feature: Templates > Checklists > Admin User Specific
As an admin user,
I want to manange a library of templates for checklists,
So that I can present a curated list of checklist templates to regular users.

Scenario: Admin user creates a new library checklist
Given I am a logged in as an admin user
And I am on the library checklist library
When I click on "Create Checklist"
And I fill in the form with the following information:
| library_checklist_title    | New Template    |
| library_checklist_content  | ## New Template |
And I click on "Save"
Then the template called "New Template" should be saved in the library
Then I should be taken to the library checklist view page

Scenario: Admin user edits a library checklist
Given I am a logged in as an admin user
And a draft library checklist called "New Template" exists
When I click on "Edit" for the "New Template" library checklist
And I fill in the form with the following information:
| library_checklist_title    | Updated Template    |
And I click on "Save"
Then the template called "Updated Template" should be saved in the library
Then I should be taken to the library checklist view page


Scenario: Admin user archives a library checklist

Scenario: Admin user publishes a library checklist
Given I am a logged in as an admin user
And a draft library checklist called "New Template" exists
When I click on "Publish" for the "New Template" library checklist
Then the "New Template" library checklist should be available to regular users

