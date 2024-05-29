# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  admin                  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  personal_library_id    :uuid
#  personal_workspace_id  :uuid
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
# Public: User model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  encrypts :email, deterministic: true, downcase: true

  has_many :checklists, as: :assignee, class_name: 'Checklist', dependent: :destroy

  belongs_to :personal_library, class_name: 'Library', dependent: :destroy, optional: true
  belongs_to :personal_workspace, class_name: 'Workspace', dependent: :destroy, optional: true

  after_create :setup_user

  private

  def setup_personal_workspace
    Workspace.create!(owner: self, name: 'Personal Workspace').tap do |workspace|
      update!(personal_workspace: workspace)
    end
  end

  def setup_personal_library
    Library.create!(owner: self, name: 'Personal Library').tap do |library|
      update!(personal_library: library)
    end
  end

  def setup_user
    setup_personal_workspace
    setup_personal_library
  end
end
