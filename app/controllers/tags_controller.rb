# frozen_string_literal: true

# Access to the Tags page, scoped to the current user / organization
class TagsController < ApplicationController
  sidebar_item :tags

  def index; end
end
