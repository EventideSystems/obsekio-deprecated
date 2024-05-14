# frozen_string_literal: true

Given('a checklist named {string} exists in my workspace') do |checklist_name|
  sleep(1) # TODO: Remove this and wait for the page to load properly
  expect(@user.checklists.exists?(title: checklist_name)).to be true

  visit(root_path)
  expect(page).to have_content(checklist_name)
end

When('I open the checklist named {string}') do |string|
  Capybara.page.current_window.resize_to(1980, 1000) # SMELL: move this to a step definition
  find('a', text: string).click
end

When('I click on the {string} checklist item') do |string|
  element = find('.task-list-item') do |checkbox|
    checkbox.text&.include?(string)
  end

  expect(element).to be_present
  element.click
  sleep(1) # TODO: Remove this and wait for the page to load properly
end

When('I click on the {string} link in the checklist') do |string|
  click_on(string)
end

Then('a checklist named {string} will be present in my workspace') do |checklist_name|
  expect(page).to have_content(checklist_name)
end

Then('the {string} checklist item will be marked as checked') do |string|
  element = find_all('.task-list-item').find('.checked') do |checkbox|
    checkbox.text&.include?(string)
  end

  expect(element).to be_present
end
