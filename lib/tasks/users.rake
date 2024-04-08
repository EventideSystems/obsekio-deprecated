# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
namespace :users do
  desc 'Create an admin user'
  task create_admin: :environment do
    email = ENV.fetch('EMAIL', nil)
    password = password_confirmation = ENV.fetch('PASSWORD', nil)

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

  namespace :workspace do
    desc 'Setup workspace for user'
    task setup: :environment do
      email = ENV.fetch('EMAIL', nil)

      if email.blank?
        puts 'You must provide the email for the user, e.g. rake users:setup_workspace EMAIL=[email]'
        exit
      end

      user = User.find_by(email:)
      force = ENV.fetch('FORCE', false)

      if user.blank?
        puts 'User not found'
        exit
      end

      Workspace::Setup.call(user, force:)
    end
  end
end
# rubocop:enable Metrics/BlockLength
