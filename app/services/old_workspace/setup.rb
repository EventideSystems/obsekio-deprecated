# frozen_string_literal: true

module OldWorkspace
  # Description: This service class is responsible for setting up the workspace for the user.
  class Setup
    attr_reader :user, :force

    def self.call(user, force: false)
      new(user, force:).call
    end

    def initialize(user, force: false)
      @user = user
      @force = force.in?([true, 'true', 't', '1', 1])
    end

    def call
      remove_introduction_checklist if force
      setup_introduction_checklist
    end

    private

    INTRODUCTION_CHECKLIST_TITLE = 'Introduction to Obsekio'
    INTRODUCTION_CHECKLIST_CONTENT = <<~CONTENT
      # Welcome to Obsekio!

      We're excited to have you on board! Here are a few things you should do to get started:
      - [ ] Review your [Account Settings](/settings/account)
      - [ ] Read the [Obsekio Handbook](https://handbook.obsekio.com)
      - [ ] Watch the [Obsekio Onboarding Video](https://www.youtube.com/watch?v=dQw4w9WgXcQ)
      - [ ] Join the #general channel on Slack
      - [ ] Complete the [Obsekio Training Course](https://training.obsekio.com)

      Feel free to check things off as you go. If you have any questions, don't hesitate to ask!
    CONTENT

    def remove_introduction_checklist
      user.checklists.find_by(title: INTRODUCTION_CHECKLIST_TITLE)&.destroy
    end

    def setup_introduction_checklist
      return if user.checklists.exists?(title: INTRODUCTION_CHECKLIST_TITLE)

      Checklist.create!(
        title: INTRODUCTION_CHECKLIST_TITLE,
        content: INTRODUCTION_CHECKLIST_CONTENT,
        assignee: user
      )
    end
  end
end
