# frozen_string_literal: true

When('I fill in the form with the following information:') do |table|
  table.rows_hash.each do |field, value|
    fill_in field, with: value
  end
end
