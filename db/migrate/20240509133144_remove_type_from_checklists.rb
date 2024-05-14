class RemoveTypeFromChecklists < ActiveRecord::Migration[7.1]
  def change
    remove_column :checklists, :type, :string
  end
end
