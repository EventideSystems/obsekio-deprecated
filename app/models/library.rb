# frozen_string_literal: true

# == Schema Information
#
# Table name: libraries
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  owner_type :string
#  public     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :uuid
#
# Indexes
#
#  index_libraries_on_owner                    (owner_type,owner_id)
#  index_libraries_on_owner_id_and_owner_type  (owner_id,owner_type)
#
class Library < ApplicationRecord
  belongs_to :owner, polymorphic: true, optional: true

  has_many :checklists, class_name: 'Checklist', inverse_of: :container, dependent: :destroy

  scope :public_libraries, -> { where(public: true) }
end
