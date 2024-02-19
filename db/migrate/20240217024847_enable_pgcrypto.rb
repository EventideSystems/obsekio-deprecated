# frozen_string_literal: true

# Allow use of UUIDs as primary keys
class EnablePgcrypto < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto'
  end
end
