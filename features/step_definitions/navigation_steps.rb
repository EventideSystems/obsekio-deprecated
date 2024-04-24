# frozen_string_literal: true

Given('I am on the dashboard') do
  visit(root_path)
end

Given('I am on the library checklist page') do
  visit library_checklists_path
end

When('I click on {string}') do |string|
  click_on(string)
end

When('I visit my workspace page') do
  visit(root_path)
end

When('I click on the {string} link') do |string|
  click_on(string)
end

Then('will be redirected to the account settings page') do
  expect(page).to have_current_path(settings_account_path, ignore_query: true)
end

Then('I should be taken to the library checklist') do
  expect(page).to have_current_path(library_checklists_path, ignore_query: true)
end
