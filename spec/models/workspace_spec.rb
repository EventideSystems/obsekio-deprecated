# frozen_string_literal: true

# == Schema Information
#
# Table name: workspaces
#
#  id         :uuid             not null, primary key
#  name       :string
#  owner_type :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :uuid             not null
#
# Indexes
#
#  index_workspaces_on_owner                    (owner_type,owner_id)
#  index_workspaces_on_owner_id_and_owner_type  (owner_id,owner_type)
#
require 'rails_helper'

RSpec.describe Workspace, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
