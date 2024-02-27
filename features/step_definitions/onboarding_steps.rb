# frozen_string_literal: true

require 'timeout'

Given('I am logged out') do
  delete(destroy_user_session_path)
end

Given('I am on the sign up page') do
  visit(new_user_registration_path)
end

Given('I have signed up') do
  visit(new_user_registration_path)
  fill_in('Email', with: 'user@obsekio.com')
  fill_in('Password', with: 'password1234')
  fill_in('Password confirmation', with: 'password1234')
  click_button('Sign up')
end

When('I fill in the form with valid information') do
  fill_in('Email', with: 'user@obsekio.com')
  fill_in('Password', with: 'password1234')
  fill_in('Password confirmation', with: 'password1234')
end

When('I fill in the form with invalid information') do
  fill_in('Email', with: 'user_obsekio_com')
  fill_in('Password', with: 'password1234')
  fill_in('Password confirmation', with: 'password4567')
end

When('I click the sign up button') do
  click_button('Sign up')
end

When('I click the link in the confirmation email') do
  deliveries = ActionMailer::Base.deliveries
  confirmation_instructions = deliveries.detect { |mail| mail['subject'].value == 'Confirmation instructions' }
  expect(confirmation_instructions).to be_present

  confirmation_link = \
    confirmation_instructions
    .body
    .to_s
    .match(%r{http://localhost:3000/users/confirmation\?confirmation_token=[a-zA-Z0-9]+})
    .to_s

  visit(confirmation_link)

  Timeout.timeout(10) do
    sleep(1) until User.find_by(email: 'user@obsekio.com').confirmed?
  end
end

Then('I should be redirected to the home page') do
  expect(page).to have_current_path(root_path, ignore_query: true)
end

Then('I should be redirected to the sign in page') do
  expect(page).to have_current_path(new_user_session_path, ignore_query: true)
end

Then('I should see a message prompting me to check my email') do
  expect(page)
    .to have_content(I18n.t('devise.registrations.signed_up_but_unconfirmed'))
end

Then('I should see a message confirming my email address') do
  expect(page)
    .to have_content(I18n.t('devise.confirmations.confirmed'))
end

Then('I should see an error message') do
  expect(page).to have_content("Password confirmation doesn't match Password")
end

Then('I should still be on the sign up page') do
  expect(page).to have_current_path("/users", ignore_query: true)
end
