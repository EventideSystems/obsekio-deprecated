class AddInstanceModelToChecklists < ActiveRecord::Migration[7.1]
  def change
    add_column :checklists, :instance_model, :string, null: false, default: 'single'
  end
end
