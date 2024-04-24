# frozen_string_literal: true

Given('a draft library checklist called {string} exists') do |title|
  @library_checklist = Library::Checklist.create!(
    title:,
    status: :draft,
    content: '## Test library checklist Content'
  )
end

Given('a published library checklist called {string} exists') do |title|
  @library_checklist = Library::Checklist.create!(
    title:,
    status: :published,
    public: true,
    content: '## Test library checklist Content'
  )
end

Given('I am on the library checklist view page') do
  visit library_checklist_path(@library_checklist)
end

When('I click on a library checklist called {string}') do |name|
  click_on name
end

When('I click on {string} for the {string} template checklist') do |button, title|
  @library_checklist = Library::Checklist.find_by(title:)

  visit library_checklist_path(@library_checklist)
  click_on(button)
end

Then('the template called {string} should be saved in the library') do |title|
  @library_checklist = Library::Checklist.find_by(title:)
  expect(@library_checklist).to be_present
end

Then('I should be taken to the library checklist view page') do
  expect(page).to have_current_path(library_checklist_path(@library_checklist), ignore_query: true)
end

Then('I should see a success message') do
  expect(page).to have_content('successfully')
end

Then('the copied checklist should be in my workspace') do
  visit root_path
  expect(page).to have_content(@library_checklist.title)
end

Then('the {string} library checklist should be available to regular users') do |title|
  click_on('Sign out')
  step('I am a logged in as a regular user')
  visit library_checklists_path
  expect(page).to have_content(title)
end
