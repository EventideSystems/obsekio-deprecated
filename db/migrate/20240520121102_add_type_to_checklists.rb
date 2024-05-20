class AddTypeToChecklists < ActiveRecord::Migration[7.1]
  def up
    add_column :checklists, :type, :string
    add_index :checklists, :type

    execute <<-SQL
      UPDATE checklists
      SET type = 'Checklists::Single'
      where instance_model = 'single'
    SQL

    remove_column :checklists, :instance_model, :string
  end

  def down
    add_column :checklists, :instance_model, :string

    execute <<-SQL
      UPDATE checklists
      SET instance_model = 'single'
      where type = 'Checklists::Single'
    SQL

    remove_index :checklists, :type
    remove_column :checklists, :type, :string
  end
end
