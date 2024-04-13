# frozen_string_literal: true

# Non-ActiveRecord model to represent a checklist item
class ChecklistItem
  include ActiveModel::Model

  attr_accessor :checked, :index, :text
end
