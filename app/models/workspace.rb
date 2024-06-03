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
class Workspace < ApplicationRecord
  belongs_to :owner, polymorphic: true

  has_many :checklists, class_name: 'Checklist', inverse_of: :container, dependent: :destroy
end
