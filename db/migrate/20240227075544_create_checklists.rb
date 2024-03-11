class CreateChecklists < ActiveRecord::Migration[7.1]
  def change
    create_table :checklists, id: :uuid do |t|
      t.string :title
      t.string :body
      t.timestamps
    end
  end
end
