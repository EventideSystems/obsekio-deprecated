# Change the assignee_id column type from bigint to uuid in the checklists table.
#
# The original assignee_id column type was bigint, incompatible with user records' id column type, which is uuid.
# Future assingee records (e.g. team records) will also have uuid as their id column type.
#
# While not ideal, this migration mutates any existing bigint assignee_id values to uuid by padding the bigint value
# with zeroes. E.g. a bigint value of 1 will be converted to a uuid value of 00000000-0000-0000-0000-000000000001.
#
# NB This approach runs counter to [RFC4122](https://www.rfc-editor.org/rfc/rfc4122), where uuids should be generated
# using a random or pseudo-random mechanism, but given that the number of records impacted is likely to be small or
# (most likely) non-existent - and any future ids *will* be generated randomly - this doesn't not represent any
# real risk.
#
# NOTE: This migration is not reversible.
class ChangeChecklistAssingeeIdToUuid < ActiveRecord::Migration[7.1]
  def change
    change_column :checklists, :assignee_id, "uuid using (uuid(lpad(replace(text(assignee_id),'-',''), 32, '0')))"
  end
end
