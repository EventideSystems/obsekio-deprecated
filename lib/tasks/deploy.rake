# frozen_string_literal: true

namespace :deploy do
  HEROKU_STAGING_DEPLOY = <<~BASH
    git push -f obsekio-staging staging:main && \
    heroku run rake db:migrate -a obsekio-staging && \
    heroku restart -a obsekio-staging
  BASH

  HEROKU_PRODUCTION_DEPLOY = <<~BASH
    git push -f obsekio-production main:main && \
    heroku run rake db:migrate -a obsekio-production && \
    heroku restart -a obsekio-production
  BASH

  def print_warning(deploy_environment)
    printf <<~TEXT
      \033[31m
      WARNING! You are about to deploy to the obsekio '#{deploy_environment}' environment.
      \033[0m
    TEXT
  end

  def print_confirmation(deploy_environment)
    print "Are you ready to release to '#{deploy_environment}'? Type 'yes' to continue: "
  end

  def confirmed?
    STDIN.gets.strip.upcase == 'YES'
  end

  desc 'deploy to staging environment'
  task :staging do
    print_warning('staging')
    print_confirmation('staging')
    if confirmed?
      sh(HEROKU_STAGING_DEPLOY)
    else
      puts 'Cancelling release.'
    end
  end

  desc 'deploy to production environment'
  task :production do
    print_warning('PRODUCTION')
    print_confirmation('PRODUCTION')
    if confirmed?
      sh(HEROKU_PRODUCTION_DEPLOY)
    else
      puts 'Cancelling release.'
    end
  end
end
