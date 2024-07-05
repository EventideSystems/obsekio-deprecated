# frozen_string_literal: true

# == Schema Information
#
# Table name: context_instances
#
#  id         :uuid             not null, primary key
#  data       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  context_id :uuid             not null
#
# Indexes
#
#  index_context_instances_on_context_id  (context_id)
#  index_context_instances_on_data        (data) USING gin
#
# Foreign Keys
#
#  fk_rails_...  (context_id => contexts.id)
#
require 'rails_helper'

RSpec.describe ContextInstance, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
