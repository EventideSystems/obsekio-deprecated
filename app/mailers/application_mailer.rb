# frozen_string_literal: true

# Base mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'from@obsek.io'
  layout 'mailer'
end
