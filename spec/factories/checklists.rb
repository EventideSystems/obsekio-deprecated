# frozen_string_literal: true

# == Schema Information
#
# Table name: checklists
#
#  id                                 :uuid             not null, primary key
#  assignee_type                      :string
#  container_type                     :string
#  content                            :text
#  data_entry_checkbox_checked_color  :string           default("green"), not null
#  data_entry_comments                :string           default("disabled"), not null
#  data_entry_input_type              :string           default("checkbox"), not null
#  data_entry_radio_additional_states :jsonb
#  data_entry_radio_primary_color     :string           default("green"), not null
#  data_entry_radio_primary_text      :string
#  data_entry_radio_secondary_color   :string           default("amber"), not null
#  data_entry_radio_secondary_text    :string
#  instance_model_name                :string           default("Instance"), not null
#  log_data                           :jsonb
#  metadata                           :jsonb
#  status                             :string
#  title                              :string
#  type                               :string
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  assignee_id                        :uuid
#  container_id                       :uuid
#  created_by_id                      :uuid
#
# Indexes
#
#  index_checklists_on_assignee       (assignee_type,assignee_id)
#  index_checklists_on_container      (container_type,container_id)
#  index_checklists_on_created_by_id  (created_by_id)
#  index_checklists_on_status         (status)
#  index_checklists_on_title          (title)
#  index_checklists_on_type           (type)
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id)
#
FactoryBot.define do
  factory :checklist do
  end
end
