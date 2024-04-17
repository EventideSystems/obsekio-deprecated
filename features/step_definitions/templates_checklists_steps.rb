# frozen_string_literal: true

Given('a draft template checklist called {string} exists') do |title|
  @template_checklist = Templates::Checklist.create!(
    title:,
    status: :draft,
    content: '## Test template checklist Content'
  )
end

Given('a published template checklist called {string} exists') do |title|
  @template_checklist = Templates::Checklist.create!(
    title:,
    status: :published,
    content: '## Test template checklist Content'
  )
end

Given('I am on the template checklist view page') do
  visit templates_checklist_path(@template_checklist)
end

When('I click on a template checklist called {string}') do |name|
  click_on name
end

When('I click on {string} for the {string} template checklist') do |button, title|
  @template_checklist = Templates::Checklist.find_by(title:)

  visit templates_checklist_path(@template_checklist)
  click_on(button)
end

Then('the template called {string} should be saved in the library') do |title|
  @template_checklist = Templates::Checklist.find_by(title:)
  expect(@template_checklist).to be_present
end

Then('I should be taken to the template checklist view page') do
  expect(page).to have_current_path(templates_checklist_path(@template_checklist), ignore_query: true)
end

Then('I should see a success message') do
  expect(page).to have_content('successfully')
end

Then('the copied checklist should be in my library') do
  visit library_checklists_path
  expect(page).to have_content(@template_checklist.title)
end

Then('the {string} template checklist should be available to regular users') do |title|
  click_on('Sign out')
  step('I am a logged in as a regular user')
  visit templates_checklists_path
  expect(page).to have_content(title)
end
