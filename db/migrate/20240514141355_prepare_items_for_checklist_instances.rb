class PrepareItemsForChecklistInstances < ActiveRecord::Migration[7.1]
  def up
    ChecklistInstance.find_each do |instance|
      instance.prepare_items
      instance.save!
    end
  end

  def down
    # NO OP
  end
end
