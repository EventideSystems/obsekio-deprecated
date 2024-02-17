# frozen_string_literal: true

namespace :users do
  desc 'Create an admin user'
  task create_admin: :environment do
    if ENV['EMAIL'].blank? || ENV['PASSWORD'].blank?
      puts 'You must provide an email and password, e.g. rake users:create_admin EMAIL=[email] PASSWORD=[password]'
      exit
    end

    if User.where(email: ENV['EMAIL']).exists?
      puts 'Admin user already exists'
      exit
    end

    User.create!(
      email: ENV['EMAIL'],
      password: ENV['PASSWORD'],
      password_confirmation: ENV['PASSWORD'],
      admin: true, confirmed_at: Time.zone.now
    )

    puts 'Admin user already exists'
  end
end
