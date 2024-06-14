class AddInstanceModelNameToChecklists < ActiveRecord::Migration[7.1]
  def change
    add_column :checklists, :instance_model_name, :string, null: false, default: 'Instance'
  end
end
