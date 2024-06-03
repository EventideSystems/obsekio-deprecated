class AddPublicFlagToLibraries < ActiveRecord::Migration[7.1]
  def change
    add_column :libraries, :public, :boolean, default: false

    reversible do |dir|
      dir.up { update_public_column(true) }
      dir.down { update_public_column(false) }
    end
  end

  private

  def update_public_column(state)
    Library.where(name: 'System Library').find_each { |library| library.update_column(:public, state) }
  end
end
