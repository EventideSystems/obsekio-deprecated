Feature: Templates > Checklists > Admin User Specific
As an admin user,
I want to manange a library of templates for checklists,
So that I can present a curated list of checklist templates to regular users.

Scenario: Admin user creates a new template checklist
Given I am a logged in as an admin user
And I am on the template checklist library
When I click on "Create Checklist"
And I fill in the form with the following information:
| templates_checklist_title    | New Template    |
| templates_checklist_content  | ## New Template |
And I click on "Save"
Then the template called "New Template" should be saved in the library
Then I should be taken to the template checklist view page

Scenario: Admin user edits a template checklist
Given I am a logged in as an admin user
And a draft template checklist called "New Template" exists
When I click on "Edit" for the "New Template" template checklist
And I fill in the form with the following information:
| templates_checklist_title    | Updated Template    |
And I click on "Save"
Then the template called "Updated Template" should be saved in the library
Then I should be taken to the template checklist view page


Scenario: Admin user archives a template checklist

Scenario: Admin user publishes a template checklist
Given I am a logged in as an admin user
And a draft template checklist called "New Template" exists
When I click on "Publish" for the "New Template" template checklist
Then the "New Template" template checklist should be available to regular users

