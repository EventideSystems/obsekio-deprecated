# frozen_string_literal: true

# Access to the Teams page, scoped to the current user / organization
class TeamsController < ApplicationController
  sidebar_item :teams

  def index; end
end
