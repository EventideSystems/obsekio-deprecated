# frozen_string_literal: true

# Non-ActiveRecord model to represent a checklist item and its state
class ChecklistItem
  include ActiveModel::Model

  attr_accessor :state, :text
end
