class RemoveCreatedByIdFromChecklists < ActiveRecord::Migration[7.1]
  def change
    remove_column :checklists, :created_by_id, :uuid
  end
end
