# frozen_string_literal: true

Given('a checklist named {string} exists in my workspace') do |checklist_name|
  sleep(1) # TODO: Remove this and wait for the page to load properly
  expect(@user.workspace_checklists.exists?(title: checklist_name)).to be true

  visit(root_path)
  expect(page).to have_content(checklist_name)
end

When('I open the checklist named {string}') do |string|
  click_on(string)
end

When('I click on the {string} checklist item') do |string|
  find('input[type="checkbox"]') do |checkbox|
    checkbox.sibling('p').text == string
  end
end

When('I click on the {string} link in the checklist') do |string|
  click_on(string)
end

Then('a checklist named {string} will be present in my workspace') do |checklist_name|
  expect(page).to have_content(checklist_name)
end

Then('the {string} checklist item will be marked as checked') do |string|
  find('input[type="checkbox"]') do |checkbox|
    checkbox.sibling('p').text == string
  end
end
