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
require 'rails_helper'

RSpec.describe Library, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
