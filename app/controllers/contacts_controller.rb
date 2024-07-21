# frozen_string_literal: true

# Access to the Contacts page, scoped to the current user / organization
class ContactsController < ApplicationController
  sidebar_item :contacts

  def index; end
end
