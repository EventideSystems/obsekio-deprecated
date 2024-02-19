# frozen_string_literal: true

namespace :users do
  desc 'Create an admin user'
  task create_admin: :environment do
    email = ENV.fetch('EMAIL', nil)
    password = ENV.fetch('PASSWORD', nil)

    if email.blank? || password.blank?
      puts 'You must provide an email and password, e.g. rake users:create_admin EMAIL=[email] PASSWORD=[password]'
      exit
    end

    if User.exists?(email:)
      puts 'User already exists'
      exit
    end

    User.create!(
      email:,
      password:,
      password_confirmation:,
      admin: true,
      confirmed_at: Time.zone.now
    )

    puts 'Admin user created'
  end
end
