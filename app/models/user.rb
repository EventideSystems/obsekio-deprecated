# frozen_string_literal: true

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
