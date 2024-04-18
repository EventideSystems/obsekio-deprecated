# frozen_string_literal: true

Given('I am a new user in the system') do
  @new_user = User.create!(
    email: 'new_user@obsekio.com',
    password: 'password',
    password_confirmation: 'password',
    confirmed_at: Time.zone.now
  )
end

Given('I am logged in') do
  @user = User.create!(
    email: 'user@obsekio.com',
    password: 'password',
    password_confirmation: 'password',
    confirmed_at: Time.zone.now
  )

  visit(new_user_session_path)
  fill_in('Email', with: @user.email)
  fill_in('Password', with: 'password')
  click_button('Sign in')
end

Given('I am a logged in as an admin user') do
  @user = User.create!(
    email: 'admin@obsekio.com',
    password: 'password',
    password_confirmation: 'password',
    confirmed_at: Time.zone.now,
    admin: true
  )

  visit(new_user_session_path)
  fill_in('Email', with: @user.email)
  fill_in('Password', with: 'password')
  click_button('Sign in')
end

Given('I am a logged in as a regular user') do
  @user = User.create!(
    email: 'user@obsekio.com',
    password: 'password',
    password_confirmation: 'password',
    confirmed_at: Time.zone.now,
    admin: false
  )

  visit(new_user_session_path)
  fill_in('Email', with: @user.email)
  fill_in('Password', with: 'password')
  click_button('Sign in')
end

When('I log in for the first time') do
  visit(new_user_session_path)
  fill_in('Email', with: 'new_user@obsekio.com')
  fill_in('Password', with: 'password')
  click_button('Sign in')
end
