# frozen_string_literal: true

require 'cucumber/rspec/doubles'

Capybara.javascript_driver = :selenium_chrome_headless
Capybara.default_max_wait_time = 10
Capybara.server_port = 3000
Capybara.server = :puma, { Silent: true }
Capybara.enable_aria_label = true
