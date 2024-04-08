# frozen_string_literal: true

When('I visit my workspace page') do
  visit(root_path)
end

Then('will be redirected to the account settings page') do
  expect(page).to have_current_path(settings_account_path, ignore_query: true)
end
