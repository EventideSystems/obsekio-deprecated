class RemoveContainerTypeFromChecklists < ActiveRecord::Migration[7.1]
  def change
    remove_column :checklists, :container_type, :string if column_exists?(:checklists, :container_type)
  end
end
