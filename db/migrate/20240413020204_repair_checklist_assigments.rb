# This migration is to fix the assignee association for the Checklist model, originally defined using an incorrect
# bigint type. The assignee_id was changed to a uuid type in a previous migration, but the assignee association was
# not updated correctly.
#
# Incorrectly converted assignee_id fields contain the first numerical part of the uuid, which is not a valid id
# for the User model but can be used to deduce the correct record. It appears that the big_int field contained the
# intial numerical part of the uuid, so we can use this to find the correct record. This will not work if the id
# started with a non-numerical character, so some records may not be fixed.
#
# NOTE: This migration is not reversible.

# Redeclare the Checklist and User models to ensure this migration can be run in isolation
class Checklist < ApplicationRecord
  belongs_to :assignee, polymorphic: true
end

class User < ApplicationRecord;end

class RepairChecklistAssigments < ActiveRecord::Migration[7.1]
  def up
    repaired = 0
    orphaned = 0
    Checklist.where(assignee_type: 'User').find_each do |checklist|
      assignee = find_assignee(checklist.assignee_id)
      if assignee
        checklist.update(assignee: assignee)
        repaired += 1
      else
        orphaned += 1
      end
    end

    puts 'Checklist assignee associations repaired...'
    puts "Checklists repaired: #{repaired}"
    puts "Checklists orphaned: #{orphaned}"
  end

  def down
    # This migration is not reversible
  end

  private

  # Find the correct assignee record based on the assignee_id
  # The assignee_id is a uuid, but the numerical part of the uuid is used to find the correct record.
  # If no unambiguous match is found, nil is returned.
  def find_assignee(assignee_id)
    assignee_id_as_int = assignee_id.delete('-').to_i

    users = User.where("id::text like '#{assignee_id_as_int}%'")
    users.count == 1 ? users.first : nil
  end
end
