class AddAssigneeToChecklists < ActiveRecord::Migration[7.1]
  def change
    add_reference :checklists, :assignee, polymorphic: true, null: true
  end
end
